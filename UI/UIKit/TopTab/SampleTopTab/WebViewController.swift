//
//  WebViewController.swift
//  SampleTopTab
//
//  Created by Yamaguchi on 2021/01/13.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var url: String = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        
        self.loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.viewWillAppear(animated)
        
    }
    
    /// WebViewの読み込みを行う
    private func loadWebView() {
        
        let url = URL(string: self.url)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
}
