//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let wifiObserver = WifiObserver()
        wifiObserver.start()
    }

}

