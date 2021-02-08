//
//  AppDelegate.swift
//  SampleSnippet
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        /*
        NetworkManager.init().getUrlSession(
            urlString: "https://httpbin.org/get",
            queryItems: [URLQueryItem(name: "a", value: "foo"), URLQueryItem(name: "b", value: "1234")])
        */
        
        /*
        NetworkManager.init().postUrlSession(
            urlString: "https://httpbin.org/post",
            parameter: "a=foo&b=1234")
        */
        
        //NetworkManager.init().downloadImage(url: "https://httpbin.org/image/png")
        
        /*
        let gcd = GCDSnippet.init()
        gcd.execute()
        gcd.execute()
        */
        
        /*
        let gcd = GCDSnippet.init()
        gcd.executeSemaphore()
        gcd.executeSemaphore()
        */
        
        //ArrayDictionarySnippet.init()
        
        /*
        let propertySample = PropertySample.init(str: "yamaguchi")
        print("propertySample.myString = \(propertySample.myString)")
        propertySample.myName = "taro"
        print("propertySample.myName = \(String(describing: propertySample.myName))")
        propertySample.myStringObserved = "あいうえお"
        print("propertySample.myStringObserved = \(propertySample.myStringObserved)")
        
        var hoge = "BBBB"
        var propertySample2 = PropertySample.init(str: "yamaguchi", hoge: &hoge) // &で参照渡し
        */
        
        /*
        // Enum
        print("EnumSample.monday = \(EnumSample.monday)") // case名 monday
        print("EnumSample.monday = \(EnumSample.monday.rawValue)") // case名に対応するInteger
        */
    }
    
}

