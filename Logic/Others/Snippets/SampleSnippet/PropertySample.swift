//
//  PropertySample.swift
//  SampleSnippet
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

class PropertySample: NSObject {

    // ストアドプロパティ
    var myString: String
    var myStringOptional: String?
    
    // フェイラブルイニシャライザ
    init?(str: String?) {
        
        guard let str = str else {
            return nil
        }
        self.myString = str
        
        // myStringOptionalのほうは初期化する必要はない
    }
    
    // 指定イニシャライザ
    init(str: String) {

        self.myString = str
    }
    
    // コンビニエンスイニシャライザ
    convenience override init() {
        
        self.init(str: "1234")
        //self.init() // こっちでもよい
    }
    
    // inoutで参照渡し
    convenience init(str: String, hoge: inout String) {

        hoge = hoge + "aaaa"
        print("hoge = \(hoge)")
        
        self.init(str: str)
    }
    
    // コンピューテッドプロパティ
    // getterの定義は任意だが、setterの定義は必須
    var myName: String? {
        
        get {
            return UserDefaults.standard.string(forKey: "myName")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "myName")
            UserDefaults.standard.synchronize()
        }
    }
    
    // ストアドプロパティ　プロバティオブザーバ
    var myStringObserved = "" {
        
        willSet {
            
            print("WillSet \(newValue)")
        }
        
        didSet {
            
            print("didSet \(self.myStringObserved)")
        }
    }
    
}
