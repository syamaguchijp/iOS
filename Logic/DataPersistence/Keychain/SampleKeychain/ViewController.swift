//
//  ViewController.swift
//  SampleKeychain
//
//  Created by Yamaguchi on 2021/01/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyName = "KeyName"
        
        KeychainHelper.save(key: keyName, value: "AAAAAA")
        
        let ans = KeychainHelper.read(key: keyName)
        print("ans=\(ans.0)")
        
        KeychainHelper.delete(key: keyName)
        
    }

}

