//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let snackBar = SnackBarView.init(labelText: "今日は良い天気です。", buttonText: "OK")
        snackBar.titleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        snackBar.start(baseView: self.view, completion: { () -> Void in
            print("complete!!!")
        })
        
    }


}

