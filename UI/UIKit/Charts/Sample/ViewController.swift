//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.configuration.userContentController.add(self, name: "dumpCallback") // JS側からのコールバック
        
        if let html = Bundle.main.path(forResource: "test", ofType: "html") {
            let url = URL(fileURLWithPath: html)
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // MARK: WKScriptMessageHandler
    
    // JS側からのメッセージを受け取る
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
           if (message.name == "dumpCallback") {
                print("didReceive message \(message.body)")
           }
    }

    // MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // HTMLの読み込みが終わってからでないとJavascriptを実行できないため、ここに記述する
        
        // 円グラフ
        let pieChartData: [[Any]] = [
            ["東京", 50], ["大阪", 30], ["新潟", 10]
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: pieChartData, options: [])
            let jsonEncodedData = jsonData.base64EncodedString(options: [])
            let javascript = "drawPieChart('\(jsonEncodedData)')"
            webView.evaluateJavaScript(
                javascript, completionHandler: { (object, error) -> Void in
            })
        } catch let error as NSError {
            print(error)
        }
        
        // 折れ線グラフ
        let lineChartData: [[Any]] = [
            ["年", "消費量", "価格"],
            ["2018", 800, 120],
            ["2019", 600, 100],
            ["2020", 900, 150],
            ["2021", 500, 170]
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: lineChartData, options: [])
            let jsonEncodedData = jsonData.base64EncodedString(options: [])
            let javascript = "drawLineChart('\(jsonEncodedData)')"
            webView.evaluateJavaScript(
                javascript, completionHandler: { (object, error) -> Void in
            })
        } catch let error as NSError {
            print(error)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    }
  
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
}

