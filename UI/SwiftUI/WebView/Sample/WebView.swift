//
//  WebView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/19.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var urlString: String
    var indicatorView = UIActivityIndicatorView()
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            
            print("\(String(describing: type(of: self))) \(#function)")
            startNetworkIndicator()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            print("\(String(describing: type(of: self))) \(#function)")
            finishNetworkIndicator()
        }
        
        private func startNetworkIndicator() {
            
            parent.indicatorView.isHidden = false
            parent.indicatorView.startAnimating()
        }
        
        private func finishNetworkIndicator() {
            
            parent.indicatorView.isHidden = false
            parent.indicatorView.stopAnimating()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        
        print("\(String(describing: type(of: self))) \(#function)")
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        print("\(String(describing: type(of: self))) \(#function)")
        
        let webView = WKWebView()
        
        webView.addSubview(indicatorView)
        
        indicatorView.style = .large
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
        
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
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://yahoo.co.jp")
    }
}
