//
//  ViewController.swift
//  SampleSlideMenu
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var leftVC: SlideMenuLeftViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard: UIStoryboard = self.storyboard!
        leftVC = storyboard.instantiateViewController(withIdentifier: "SlideMenuLeftViewController") as? SlideMenuLeftViewController
        
        SlideMenuController.shared.leftSlideMenuView = leftVC!.view
        SlideMenuController.shared.rightMainView = self.view
    }

    /// ナビゲーションバー左側 ハンバーガーをタップした時にコールされる
    @IBAction func didTapHamburger(_ sender: Any) {
        // 左側スライドメニューを開く
        SlideMenuController.shared.openMenu()
    }
    
}

