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
    }
    
    deinit {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    @objc func didTapMySelf(sender : UITapGestureRecognizer) {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        self.dismiss(animated: true, completion: nil)
    }
}
