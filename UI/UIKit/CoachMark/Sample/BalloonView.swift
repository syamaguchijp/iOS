//
//  BalloonView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/12.
//

import UIKit

class BalloonView: UIView {
    
    let titleLabel = UILabel()
    
    var xPadding = CGFloat(10)
    var yPadding = CGFloat(10)
    
    override init(frame: CGRect) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.init(frame: frame)
        
        self.frame = CGRect.zero
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        titleLabel.frame = CGRect.zero
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        specifyParams()
    }

    required init?(coder aDecoder: NSCoder) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        super.init(coder: aDecoder)
    }
    
    convenience init(labelText: String, color: UIColor) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        self.init(frame: .zero)
        
        titleLabel.text = labelText
        self.backgroundColor = color
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    func specifyParams() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        self.layer.cornerRadius = CGFloat(5)
        titleLabel.textColor = .white
        
        do {
            let leading = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xPadding)
            let trailing = titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xPadding)
            let top = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: yPadding)
            let bottom = titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -yPadding)
            titleLabel.sizeToFit()
            NSLayoutConstraint.activate([leading, trailing, top, bottom])
        }
        
        self.superview?.layoutIfNeeded()
    }
}
