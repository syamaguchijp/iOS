//
//  SnackBarView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/23.
//

import UIKit

class SnackBarView: UIView {
    
    var fixedHeight = CGFloat(120)
    var buttonHeight = CGFloat(40)
    var buttonWidth = CGFloat(60)
    var buttonText = ""
    var labelText = ""
    var animationDuration = 1.0
    var sunrizeMode = false // 下からせり上がる挙動

    private let minHeight = CGFloat(100)
    private let xMargin = CGFloat(5)
    private let yMargin = CGFloat(10)
    private let xPadding = CGFloat(5)
    private let yPadding = CGFloat(5)
    private var safeAreaFrame: CGRect?
    
    override init(frame: CGRect) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        super.init(frame: frame)
        self.backgroundColor = .gray
    }

    required init?(coder aDecoder: NSCoder) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        super.init(coder: aDecoder)
    }
    
    convenience init(labelText: String, buttonText: String) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        self.init(frame: .zero)
        self.labelText = labelText
        self.buttonText = buttonText
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    func start(baseView: UIView) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        safeAreaFrame = baseView.safeAreaLayoutGuide.layoutFrame
        
        self.frame = CGRect.zero
        self.layer.cornerRadius = 5
        self.translatesAutoresizingMaskIntoConstraints = false
        baseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSuperView)))
        baseView.addSubview(self)
        
        // Button
        let actionButton = UIButton()
        actionButton.frame = CGRect.zero
        actionButton.setTitle(buttonText, for:UIControl.State.normal)
        actionButton.backgroundColor = .blue
        actionButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(actionButton)
        do {
            let trailing = actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xPadding)
            let bottom = actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -yPadding)
            let width = actionButton.widthAnchor.constraint(equalToConstant: self.buttonWidth)
            let height = actionButton.heightAnchor.constraint(equalToConstant: self.buttonHeight)
            NSLayoutConstraint.activate([trailing, bottom, width, height])
        }
        
        // Label
        let titleLabel = UILabel()
        titleLabel.frame = CGRect.zero
        titleLabel.text = labelText
        titleLabel.backgroundColor = .red
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        do {
            let leading = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xPadding)
            let trailing = titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: 0)
            let vertical = titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
            titleLabel.sizeToFit()
            NSLayoutConstraint.activate([leading, trailing, vertical])
        }
        
        // self
        let top = self.topAnchor.constraint(equalTo: baseView.topAnchor, constant: -fixedHeight)
        let leading = self.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: xMargin)
        let trailing = self.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -xMargin)
        let bottom = self.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        
        self.superview?.layoutIfNeeded()
        print("label height=\(titleLabel.frame.size.height)")
        if titleLabel.frame.size.height < minHeight {
            // Labelの高さが小さいときは、補正する
            do {
                let height = titleLabel.heightAnchor.constraint(equalToConstant: fixedHeight)
                NSLayoutConstraint.activate([height])
            }
        }
        
        // Animation開始
        self.superview?.layoutIfNeeded()
        top.constant += self.safeAreaFrame!.origin.y + self.fixedHeight
        UIView.animate(withDuration:animationDuration, delay:0.0, options:[.allowUserInteraction, .curveEaseOut], animations: {
            self.superview?.layoutIfNeeded()
        }, completion: {(finished) in
        })
    }
    
    func end() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        // Animation開始
        let top = self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: -self.frame.height)
        NSLayoutConstraint.activate([top])
        UIView.animate(withDuration:animationDuration, delay:0.0, options:[.allowUserInteraction, .curveEaseOut], animations: {
            self.superview?.layoutIfNeeded()
        }, completion: {(finished) in
            self.removeFromSuperview()
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        super.touchesEnded(touches, with: event)
        end()
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        end()
    }
    
    @objc private func didTapSuperView() {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        end()
    }
}
