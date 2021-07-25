//
//  SnackBarView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/23.
//

import UIKit

class SnackBarView: UIView {

    let actionButton = UIButton()
    let titleLabel = UILabel()
    
    var animationDuration = 1.0
    var sunriseMode = false // 下から上へせり上がる挙動
    
    private let minHeight = CGFloat(100)
    private let xMargin = CGFloat(5)
    private let yMargin = CGFloat(10)
    private let xPadding = CGFloat(5)
    private let yPadding = CGFloat(5)
    private let buttonHeight = CGFloat(40)
    private let buttonWidth = CGFloat(60)
    private let cornerRadius = CGFloat(5)
    
    private var topAnchorNormal: NSLayoutConstraint?
    private var bottomAnchorSunrise: NSLayoutConstraint?
    private var finalHeight = CGFloat(0)
    
    override init(frame: CGRect) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.init(frame: frame)
        
        self.frame = CGRect.zero
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = .gray
        self.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.frame = CGRect.zero
        actionButton.backgroundColor = .darkGray
        actionButton.setTitleColor(.red, for:.normal)
        actionButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(actionButton)
        
        titleLabel.frame = CGRect.zero
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        super.init(coder: aDecoder)
    }
    
    convenience init(labelText: String, buttonText: String) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        self.init(frame: .zero)
        
        titleLabel.text = labelText
        actionButton.setTitle(buttonText, for:.normal)
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    func start(baseView: UIView) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        // self
        baseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSuperView)))
        baseView.addSubview(self)
        do {
            let leading = self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: xMargin)
            let trailing = self.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor, constant: -xMargin)
            NSLayoutConstraint.activate([leading, trailing])
        }
        
        // Button
        do {
            let trailing = actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xPadding)
            let bottom = actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -yPadding)
            let width = actionButton.widthAnchor.constraint(equalToConstant: self.buttonWidth)
            let height = actionButton.heightAnchor.constraint(equalToConstant: self.buttonHeight)
            NSLayoutConstraint.activate([trailing, bottom, width, height])
        }
        
        // Label
        do {
            let leading = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xPadding)
            let trailing = titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: 0)
            let vertical = titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
            let bottom = titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            titleLabel.sizeToFit()
            NSLayoutConstraint.activate([leading, trailing, vertical, bottom])
        }
        
        self.superview?.layoutIfNeeded()
        print("label height=\(titleLabel.frame.size.height)")
        finalHeight = titleLabel.frame.size.height + yPadding * 2
        if finalHeight < minHeight {
            // Labelの高さが小さいときは、補正する
            finalHeight = minHeight
        }
        
        if !sunriseMode {
            startAnimation()
        } else {
            startAnimationSunrise()
        }
    }
    
    private func startAnimation() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let height = titleLabel.heightAnchor.constraint(equalToConstant: finalHeight)
        let top = self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: -finalHeight)
        NSLayoutConstraint.activate([height, top])
        topAnchorNormal = top
        self.superview?.layoutIfNeeded()
        
        // Animation開始
        top.constant += self.superview!.safeAreaLayoutGuide.layoutFrame.origin.y + finalHeight
        UIView.animate(withDuration:animationDuration, delay:0.0, options:[.allowUserInteraction, .curveEaseOut], animations: {
            self.superview?.layoutIfNeeded()
        }, completion: {(finished) in
        })
    }
    
    private func startAnimationSunrise() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let height = titleLabel.heightAnchor.constraint(equalToConstant: finalHeight)
        let bottom = self.bottomAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.bottomAnchor, constant: finalHeight)
        NSLayoutConstraint.activate([height, bottom])
        self.superview?.layoutIfNeeded()
    
        // Animation開始
        bottom.constant -= finalHeight
        bottomAnchorSunrise = bottom
        UIView.animate(withDuration:animationDuration, delay:0.0, options:[.allowUserInteraction, .curveEaseOut], animations: {
            self.superview?.layoutIfNeeded()
        }, completion: {(finished) in
        })
    }
    
    func end() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if !sunriseMode {
            startEndAnimation()
        } else {
            startEndAnimationSunrise()
        }
    }
    
    private func startEndAnimation() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        guard let topAnchorNormal = topAnchorNormal else {
            return
        }
        // Animation開始
        topAnchorNormal.constant -= (self.frame.height + self.superview!.safeAreaInsets.top)
        UIView.animate(withDuration:animationDuration, delay:0.0, options:[.allowUserInteraction, .curveEaseOut], animations: {
            self.superview?.layoutIfNeeded()
        }, completion: {(finished) in
            self.removeFromSuperview()
        })
    }
    
    private func startEndAnimationSunrise() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        guard let bottomAnchorSunrise = bottomAnchorSunrise else {
            return
        }
        // Animation開始
        bottomAnchorSunrise.constant += CGFloat(self.frame.height + self.superview!.safeAreaInsets.bottom)
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
