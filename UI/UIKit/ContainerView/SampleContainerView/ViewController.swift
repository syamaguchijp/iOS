//
//  ViewController.swift
//  SampleContainerView
//
//  Created by admin on 2017/12/15.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

// ViewControllerの中にViewControllerを入れて表示するためにcontainerViewを利用するパターン
class ViewController: UIViewController {
    
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    
    override func viewDidLoad() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        super.viewDidLoad()
        
        let fvc = FirstViewController(nibName: "FirstViewController", bundle: nil)
        addChild(fvc)
        firstContainerView.addSubview(fvc.view)
        fvc.view.frame = firstContainerView.bounds
        
        let svc = FirstViewController(nibName: "SecondViewController", bundle: nil)
        addChild(svc)
        secondContainerView.addSubview(svc.view)
        svc.view.frame = secondContainerView.bounds
    
    }

}

