//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2022/07/01.
//

import UIKit

class ViewController: UIViewController {

    private let beaconObserver = BeaconObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconObserver.start()
       
    }


}

