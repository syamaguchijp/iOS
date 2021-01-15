//
//  ViewController.swift
//  SampleWebView
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit
import WebKit

enum IrgToolBarScrollStatus: Int {
    case irgToolBarScrollStatusInit = 0, irgToolBarScrollStatusAnimation
}

class ViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {

    let kToolBarIconHeightOfWebView = 40
    let kToolBarAnimationDurationSec = 0.5
    let kApplicationTintColor: UIColor = UIColor(red: 251.0 / 255.0, green: 99.0 / 255.0, blue: 126.0 / 255.0, alpha: 1.0)
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var url: String = ""
    
    private var spacer: UIBarButtonItem?
    private var backButton: UIBarButtonItem?
    private var forwardButton: UIBarButtonItem?
    private var refreshButton: UIBarButtonItem?
    private var quitButton: UIBarButtonItem?
    private var toolBarScrollStatus: IrgToolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusInit
    private var beginScrollOffsetY: CGFloat = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.url = "https://www.apple.com/jp"
        self.webView.navigationDelegate = self
        self.webView.scrollView.delegate = self
        
        self.generateToolBar()
        self.loadWebView()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
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
    
    /// スクロールビューをドラッグし始めた際に一度コールされる
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.beginScrollOffsetY = scrollView.contentOffset.y
    }
    
    /// スクロールビューがスクロールされるたびにコールされ続ける
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if self.toolBarScrollStatus == IrgToolBarScrollStatus.irgToolBarScrollStatusAnimation {
            return;
        }
        
        if self.beginScrollOffsetY < scrollView.contentOffset.y && self.toolBar.isHidden == false {
            // スクロール前のオフセットよりスクロール後が多い = 下を見ようとしたため、ツールバーを隠す
            self.fadeOutToolBar()
            
        } else if scrollView.contentOffset.y < self.beginScrollOffsetY && self.toolBar.isHidden == true {
            // 上を見ようとしたためツールバーを出す
            self.fadeInToolBar()
            
        }
    }
    
    // MARK: WebView
    
    /// WebViewの読み込みを行う
    func loadWebView() {
        
        let url = URL(string: self.url)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
    /// ツールバーを生成する
    func generateToolBar() {
        
        self.toolBar.isHidden = false
        self.toolBar.isOpaque = false
        self.toolBar.isTranslucent = false
        
        let toolBarBgImg: UIImage? = UIImage(named: "bg_tabbar.png")
        if let img = toolBarBgImg {
            self.toolBar.setBackgroundImage(img, forToolbarPosition: .any, barMetrics: .default)
        }
        
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
        
        self.toolBar.setItems([self.backButton!, self.forwardButton!, self.refreshButton!, self.spacer!, self.spacer!], animated: false)
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
    
    /// ツールバーをフェードインして表示する
    private func fadeInToolBar() {
        
        self.toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusAnimation
        self.toolBar.alpha = 0
        self.toolBar.isHidden = false
        
        UIView.animate(withDuration: kToolBarAnimationDurationSec, animations: {() -> Void in
            self.toolBar.alpha = 1
            self.toolBar.isHidden = false
        }, completion: { finished in
            self.toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusInit
        })
    }
    
    /// ツールバーをフェードアウトして非表示にする
    private func fadeOutToolBar() {
        
        self.toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusAnimation
        self.toolBar.alpha = 1
        self.toolBar.isHidden = false
        
        UIView.animate(withDuration: kToolBarAnimationDurationSec, animations: {() -> Void in
            self.toolBar.alpha = 0
        }, completion: { finished in
            self.toolBar.isHidden = true
            self.toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusInit
        })
    }
    
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
