//
//  HalfModalViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/26.
//

import UIKit

class HalfModalViewController: UIViewController {
    
    let tapCloseMode = false
    let swipeMode = true

    @IBOutlet weak var halfView: UIView!
    
    override func viewDidLoad() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.viewDidLoad()
        
        if tapCloseMode {
            let gesture = UITapGestureRecognizer(target:self, action:#selector(didTapMySelf))
            view.addGestureRecognizer(gesture)
        }
        
        if swipeMode {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(didDrag))
            view.addGestureRecognizer(gesture)
        }
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    @objc func didTapMySelf(sender : UITapGestureRecognizer) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    let bufferY = CGFloat(50)
    let closeDiffY = CGFloat(50)
    var startY = CGFloat(0)
    
    @objc func didDrag(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            print("\(NSStringFromClass(type(of: self))) \(#function) began")
            
            startY = gestureRecognizer.view!.center.y
            
        } else if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            
            print("\(NSStringFromClass(type(of: self))) \(#function) ended")
            
        } else if gestureRecognizer.state == UIGestureRecognizer.State.changed {
            
            let velocity = gestureRecognizer.velocity(in: gestureRecognizer.view!)
            
            print("\(NSStringFromClass(type(of: self))) \(#function) y=\(gestureRecognizer.view!.center.y) velocity=\(velocity.y)")
                
            if gestureRecognizer.view!.center.y < bufferY && velocity.y < 0 {
                // これ以上上にはドラッグさせない
                print("\(NSStringFromClass(type(of: self))) \(#function) return")
                return
            }
            
            if gestureRecognizer.view!.center.y - startY > closeDiffY {
                // 下にドラッグした場合は、このモーダルを閉じる
                self.dismiss(animated: true, completion: nil)
                return
            }
            
            // viewを垂直方向に移動する
            let translation = gestureRecognizer.translation(in: self.view)
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
    }
}
