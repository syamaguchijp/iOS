//
//  ModalViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/26.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target:self, action:#selector(didTapMySelf))
        view.addGestureRecognizer(gesture)
        
        let gesture2 = UIPanGestureRecognizer(target: self, action: #selector(didDragMyself))
        view.addGestureRecognizer(gesture2)
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    @objc func didTapMySelf(sender : UITapGestureRecognizer) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        //self.dismiss(animated: true, completion: nil)
    }
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    let thresholdY = CGFloat(150)
    @objc func didDragMyself(sender: UIPanGestureRecognizer) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        switch sender.state {
            case .changed:
                viewTranslation = sender.translation(in: view)
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                })
            case .ended:
                if viewTranslation.y < thresholdY {
                    UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.view.transform = .identity
                    })
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            default:
                break
        }
    }
}
