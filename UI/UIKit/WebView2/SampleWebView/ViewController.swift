//
//  ViewController.swift
//  SampleWebView
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {

    let kToolBarIconHeightOfWebView = 40
    let kToolBarAnimationDurationSec = 0.5
    let kApplicationTintColor: UIColor = UIColor(red: 251.0 / 255.0, green: 99.0 / 255.0, blue: 126.0 / 255.0, alpha: 1.0)
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var url: String = ""
    
    private var spacer: UIBarButtonItem?
    private var backButton: UIBarButtonItem?
    private var forwardButton: UIBarButtonItem?
    private var refreshButton: UIBarButtonItem?
    private var quitButton: UIBarButtonItem?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.url = "https://www.apple.com/jp"
        
        self.webView.navigationDelegate = self
        self.webView.scrollView.delegate = self
        self.webView.allowsBackForwardNavigationGestures = true // スワイプで進む戻るを実行
        self.webView.scrollView.bounces = true
        let refreshControl = UIRefreshControl()
        self.webView.scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshWebView(sender:)), for: .valueChanged)
        
        self.generateToolBar()
        self.loadWebView()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.loadWebView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.finishNetworkIndicator()
    }
    
    // MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        self.startNetworkIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        self.finishNetworkIndicator()
        self.changeToolBarButtonStatus()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        self.finishNetworkIndicator()
        self.changeToolBarButtonStatus()
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if (velocity.y > 0) {
            // ナビゲーションバーやツールバーを非表示にする
            UIView.animate(withDuration: kToolBarAnimationDurationSec, delay: 0, options: UIView.AnimationOptions(), animations: {
                if let navigationController = self.navigationController {
                    navigationController.setNavigationBarHidden(true, animated: true)
                    navigationController.setToolbarHidden(true, animated: true)
                }
            }, completion: nil)
            
        } else {
            // ナビゲーションバーやツールバーを表示する
            UIView.animate(withDuration:kToolBarAnimationDurationSec, delay: 0, options: UIView.AnimationOptions(), animations: {
                if let navigationController = self.navigationController {
                    navigationController.setNavigationBarHidden(false, animated: true)
                    navigationController.setToolbarHidden(false, animated: true)
                }
            }, completion: nil)
        }
    }
    
    // MARK: WebView
    
    /// WebViewの読み込みを行う
    func loadWebView() {
        
        let url = URL(string: self.url)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
    // UIRefreshControlによってページをリロードする
    @objc func refreshWebView(sender: UIRefreshControl) {
        
        self.webView.reload()
        sender.endRefreshing()
    }
    
    /// ツールバーを生成する
    func generateToolBar() {
        
        self.spacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let backInnerButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        backInnerButton.setImage(UIImage(named: "btn_prev.png"), for: UIControl.State())
        backInnerButton.frame = CGRect(x: 0, y: 0, width: kToolBarIconHeightOfWebView, height: kToolBarIconHeightOfWebView)
        backInnerButton.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        self.backButton = UIBarButtonItem.init(customView: backInnerButton)
        
        let forwardInnerButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        forwardInnerButton.setImage(UIImage(named: "btn_next.png"), for: UIControl.State())
        forwardInnerButton.frame = CGRect(x: 0, y: 0, width: kToolBarIconHeightOfWebView, height: kToolBarIconHeightOfWebView)
        forwardInnerButton.addTarget(self, action: #selector(goForward), for: UIControl.Event.touchUpInside)
        self.forwardButton = UIBarButtonItem.init(customView: forwardInnerButton)
        
        let refreshInnerButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        refreshInnerButton.setImage(UIImage(named: "btn_reload.png"), for: UIControl.State())
        refreshInnerButton.frame = CGRect(x: 0, y: 0, width: kToolBarIconHeightOfWebView, height: kToolBarIconHeightOfWebView)
        refreshInnerButton.addTarget(self, action: #selector(reloadWebView), for: UIControl.Event.touchUpInside)
        self.refreshButton = UIBarButtonItem.init(customView: refreshInnerButton)
        
        let quitInnerButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        quitInnerButton.setImage(UIImage(named: "btn_close.png"), for: UIControl.State())
        quitInnerButton.frame = CGRect(x: 0, y: 0, width: kToolBarIconHeightOfWebView, height: kToolBarIconHeightOfWebView)
        quitInnerButton.addTarget(self, action: #selector(killMyself), for: UIControl.Event.touchUpInside)
        self.quitButton = UIBarButtonItem.init(customView: quitInnerButton)
        
        self.toolbarItems = [self.backButton!, self.forwardButton!, self.refreshButton!, self.spacer!, self.spacer!];
        
        //  UINavigationControllerにはもともとツールバーが組み込まれている。（デフォルト=非表示）
        if let navigationController = self.navigationController {
            navigationController.setToolbarHidden(false, animated: false)
            navigationController.toolbar.isOpaque = false
            navigationController.toolbar.isTranslucent = false
        }
        
        let toolBarBgImg: UIImage? = UIImage(named: "bg_tabbar.png")
        if let img = toolBarBgImg, let navigationController = self.navigationController {
            navigationController.toolbar.setBackgroundImage(img, forToolbarPosition: .any, barMetrics: .default)
        }
    }
    
    /// UIWebView の履歴から戻す
    @objc func goBack() {
        
        self.webView.goBack()
    }
    
    /// UIWebView の履歴から進める
    @objc func goForward() {
        
        self.webView.goForward()
    }
    
    /// UIWebView をリロードする
    @objc func reloadWebView() {
        
        if let wv = self.webView {
            if wv.canGoBack {
                wv.reload()
            } else {
                self.loadWebView()
            }
        }
    }
    
    /// 画面を閉じる
    @objc func killMyself() {
        
    }
    
    // MARK: handle toolBar
    
    /// WebView読込完了時にツールバー内のボタンの状態を変える
    private func changeToolBarButtonStatus() {
        
        // 戻るボタン
        if let btn = self.backButton {
            
            if self.webView.canGoBack == true {
                btn.tintColor = kApplicationTintColor
                btn.isEnabled = true
            } else {
                btn.tintColor = UIColor.gray
                btn.isEnabled = false
            }
        }
        
        // 進むボタン
        if let btn = self.forwardButton {
            
            if self.webView.canGoForward == true {
                btn.tintColor = kApplicationTintColor
                btn.isEnabled = true
            } else {
                btn.tintColor = UIColor.gray
                btn.isEnabled = false
            }
        }
    }
    
    // MARK: handle indicator
    
    /// 通信時のインジケータを表示する
    private func startNetworkIndicator() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.indicator.startAnimating()
        self.indicator.isHidden = false
    }
    
    /// 通信時のインジケータを終了する
    private func finishNetworkIndicator() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
    }
    
}
