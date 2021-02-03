//
//  ViewController.swift
//  SampleSlideMenu
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var leftVC: SlideMenuLeftViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storyboard: UIStoryboard = self.storyboard!
        leftVC = storyboard.instantiateViewController(withIdentifier: "SlideMenuLeftViewController") as? SlideMenuLeftViewController
        
        SlideMenuController.shared.leftSlideMenuView = leftVC!.view
        SlideMenuController.shared.rightMainView = self.view
        SlideMenuController.shared.rightMainViewController = self
        
        self.loadWebView()
    }

    /// ナビゲーションバー左側 ハンバーガーをタップした時にコールされる
    @IBAction func didTapHamburger(_ sender: Any) {
        // 左側スライドメニューを開く
        SlideMenuController.shared.openMenu()
    }
    
    /// WebViewの読み込みを行う
    func loadWebView() {
        
        let url = URL(string: SlideMenuController.shared.menus[SlideMenuController.shared.currentIndex].url)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
}

