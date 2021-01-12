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
        SlideMenuController.shared.rightMainView = self.navigationController?.view
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        // シャドウをつけ、メニュー部分とのフリンジを際立たせる
        let caLayer = self.view.layer
        caLayer.shadowOpacity = 1.0 // 影の透明度
        caLayer.shadowRadius = 1.0 // ぼかしの量
        caLayer.shadowOffset = CGSize(width: 0.0, height: 0.0) // 影のかかる方向
        caLayer.rasterizationScale = UIScreen.main.scale
        caLayer.shouldRasterize = true
        caLayer.masksToBounds = false
    }
    /// ナビゲーションバー左側 ハンバーガーをタップした時にコールされる
    @IBAction func didTapHamburger(_ sender: Any) {
        // スライドメニューをトグルさせる
        SlideMenuController.shared.toggleMenuOpen()
    }
    
}

