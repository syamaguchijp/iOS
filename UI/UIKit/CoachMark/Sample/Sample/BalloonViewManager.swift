//
//  BallonViewManager.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/12.
//

import UIKit

enum BalloonViewHorizontal: Int {
    case LEFT = 0
    case CENTER
    case RIGHT
}

class BalloonViewManager: NSObject {

    var baloonView: BalloonView?
    var xMargin = CGFloat(10)
    
    private let triangleView = UIView()
    
    func generate(baseView: UIView, targetView: UIView, labelText: String, color: UIColor,
                  horizontal: BalloonViewHorizontal) {
        
        // 三角形
        triangleView.frame = CGRect.zero
        let angle:CGFloat = 45 * .pi / 180
        triangleView.transform = CGAffineTransform(rotationAngle: angle)
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        triangleView.backgroundColor = color
        baseView.addSubview(triangleView)
        do {
            let width = triangleView.widthAnchor.constraint(equalToConstant: CGFloat(30))
            let height = triangleView.heightAnchor.constraint(equalToConstant: CGFloat(30))
            let horizontal = triangleView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor, constant: 0)
            let top = triangleView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 5)
            NSLayoutConstraint.activate([width, height, horizontal, top])
        }
        
        // 長方形
        baloonView = BalloonView.init(labelText: labelText, color: color)
        guard let baloonView = baloonView else {
            return
        }
        baseView.addSubview(baloonView)
        do {
            let width = baloonView.widthAnchor.constraint(equalTo: baloonView.superview!.widthAnchor, multiplier: CGFloat(0.7))
            let top = baloonView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant:10)
            NSLayoutConstraint.activate([width, top])
            
            if horizontal == BalloonViewHorizontal.LEFT {
                let leading = baloonView.leadingAnchor.constraint(equalTo: baloonView.superview!.leadingAnchor, constant: xMargin)
                NSLayoutConstraint.activate([leading])
                
            } else if horizontal == BalloonViewHorizontal.CENTER {
                let center = baloonView.centerXAnchor.constraint(equalTo: baloonView.superview!.centerXAnchor, constant: 0)
                NSLayoutConstraint.activate([center])
                
            } else if horizontal == BalloonViewHorizontal.RIGHT {
                let trailing = baloonView.trailingAnchor.constraint(equalTo: baloonView.superview!.trailingAnchor, constant: -xMargin)
                NSLayoutConstraint.activate([trailing])
            }
        }
    }
    
    func kill() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        triangleView.removeFromSuperview()
        baloonView?.removeFromSuperview()
        self.baloonView = nil
    }
}
