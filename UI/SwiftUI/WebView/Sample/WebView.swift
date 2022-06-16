//
//  WebView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/19.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let kToolBarIconHeightOfWebView = 40
    let kToolBarAnimationDurationSec = 0.5
    let kApplicationTintColor = UIColor(red: 251.0 / 255.0, green: 99.0 / 255.0, blue: 126.0 / 255.0, alpha: 1.0)
    let webView = WKWebView()
    let indicatorView = UIActivityIndicatorView()
    let toolBar = UIToolbar()
    let backButton = UIBarButtonItem()
    let forwardButton = UIBarButtonItem()
    let refreshButton = UIBarButtonItem()
    let backInnerButton = UIButton(type: UIButton.ButtonType.custom)
    let forwardInnerButton = UIButton(type: UIButton.ButtonType.custom)
    let refreshInnerButton = UIButton(type: UIButton.ButtonType.custom)
    
    var urlString: String
    @State var toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusInit
    
    // View側から通知すべきイベントを定義するクラス
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
        
        private var parent: WebView
        private var beginScrollOffsetY: CGFloat = 0
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // MARK: WKNavigationDelegate
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            
            print("\(String(describing: type(of: self))) \(#function)")
            parent.startNetworkIndicator()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            print("\(String(describing: type(of: self))) \(#function)")
            parent.finishNetworkIndicator()
            parent.changeToolBarButtonStatus()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            
            print("\(String(describing: type(of: self))) \(#function)")
            parent.finishNetworkIndicator()
            parent.changeToolBarButtonStatus()
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            
            print("\(String(describing: type(of: self))) \(#function)")
            parent.finishNetworkIndicator()
            parent.changeToolBarButtonStatus()
        }
        
        // MARK: UIScrollViewDelegate
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            
            print("\(String(describing: type(of: self))) \(#function)")
            
            self.beginScrollOffsetY = scrollView.contentOffset.y
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
             
            print("\(String(describing: type(of: self))) \(#function)")
            
            if parent.toolBarScrollStatus == IrgToolBarScrollStatus.irgToolBarScrollStatusAnimation {
                return;
            }
            
            if self.beginScrollOffsetY < scrollView.contentOffset.y && parent.toolBar.isHidden == false {
                // スクロール前のオフセットよりスクロール後が多い = 下を見ようとしたため、ツールバーを隠す
                parent.fadeOutToolBar()
                
            } else if scrollView.contentOffset.y < self.beginScrollOffsetY && parent.toolBar.isHidden == true {
                // 上を見ようとしたためツールバーを出す
                parent.fadeInToolBar()
            }
        }
        
        // MARK: Toolbar Button Tap Event
        
        func generateButtonTarget() {
            
            parent.backInnerButton.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
            parent.forwardInnerButton.addTarget(self, action: #selector(goForward), for: UIControl.Event.touchUpInside)
            parent.refreshInnerButton.addTarget(self, action: #selector(reloadWebView), for: UIControl.Event.touchUpInside)
        }
        
        @objc func goBack() {
            
            print("\(String(describing: type(of: self))) \(#function)")
            parent.webView.goBack()
        }
        
        @objc func goForward() {
            
            print("\(String(describing: type(of: self))) \(#function)")
            parent.webView.goForward()
        }
        
        @objc func reloadWebView() {
            
            print("\(String(describing: type(of: self))) \(#function)")
            parent.webView.reload()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        
        print("\(String(describing: type(of: self))) \(#function)")
        
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        print("\(String(describing: type(of: self))) \(#function)")
        
        webView.scrollView.delegate = context.coordinator
        webView.addSubview(indicatorView)
        context.coordinator.generateButtonTarget()
        
        generateIndicator()
        generateToolBar(webView: webView)
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        print("\(String(describing: type(of: self))) \(#function)")
        
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func generateIndicator() {
        
        indicatorView.style = .large
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
    }
    
    func generateToolBar(webView: WKWebView) {
        
        toolBar.isHidden = false
        toolBar.isOpaque = false
        toolBar.isTranslucent = false
        
        let toolBarBgImg: UIImage? = UIImage(named: "bg_tabbar.png")
        if let img = toolBarBgImg {
            toolBar.setBackgroundImage(img, forToolbarPosition: .any, barMetrics: .default)
        }
        
        let spacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        backInnerButton.setImage(UIImage(named: "btn_prev.png"), for: UIControl.State())
        backInnerButton.frame = CGRect(x: 0, y: 0, width: kToolBarIconHeightOfWebView, height: kToolBarIconHeightOfWebView)
        backButton.customView = backInnerButton
        
        forwardInnerButton.setImage(UIImage(named: "btn_next.png"), for: UIControl.State())
        forwardInnerButton.frame = CGRect(x: 0, y: 0, width: kToolBarIconHeightOfWebView, height: kToolBarIconHeightOfWebView)
        forwardButton.customView = forwardInnerButton
        
        refreshInnerButton.setImage(UIImage(named: "btn_reload.png"), for: UIControl.State())
        refreshInnerButton.frame = CGRect(x: 0, y: 0, width: kToolBarIconHeightOfWebView, height: kToolBarIconHeightOfWebView)
        refreshButton.customView = refreshInnerButton

        toolBar.setItems([backButton, forwardButton, refreshButton, spacer, spacer], animated: false)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        webView.addSubview(toolBar)
        
        let leading = toolBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0)
        let trailing = toolBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0)
        let bottom = toolBar.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, bottom])
        let heightConstraint = webView.heightAnchor.constraint(equalToConstant: 80)
        heightConstraint.isActive = true
    }
    
    func changeToolBarButtonStatus() {
        
        if self.webView.canGoBack == true {
            backButton.tintColor = kApplicationTintColor
            backButton.isEnabled = true
        } else {
            backButton.tintColor = UIColor.gray
            backButton.isEnabled = false
        }
        
        if self.webView.canGoForward == true {
            forwardButton.tintColor = kApplicationTintColor
            forwardButton.isEnabled = true
        } else {
            forwardButton.tintColor = UIColor.gray
            forwardButton.isEnabled = false
        }
    }
    
    func startNetworkIndicator() {
        
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func finishNetworkIndicator() {
        
        indicatorView.isHidden = false
        indicatorView.stopAnimating()
    }
    
    func fadeInToolBar() {
        
        toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusAnimation
        toolBar.alpha = 0
        toolBar.isHidden = false
        
        UIView.animate(withDuration: kToolBarAnimationDurationSec, animations: {() -> Void in
            self.toolBar.alpha = 1
            self.toolBar.isHidden = false
        }, completion: { finished in
            toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusInit
        })
    }
    
    func fadeOutToolBar() {
        
        toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusAnimation
        toolBar.alpha = 1
        toolBar.isHidden = false
        
        UIView.animate(withDuration: kToolBarAnimationDurationSec, animations: {() -> Void in
            self.toolBar.alpha = 0
        }, completion: { finished in
            self.toolBar.isHidden = true
            self.toolBarScrollStatus = IrgToolBarScrollStatus.irgToolBarScrollStatusInit
        })
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://yahoo.co.jp")
    }
}

enum IrgToolBarScrollStatus: Int {
    case irgToolBarScrollStatusInit = 0, irgToolBarScrollStatusAnimation
}
