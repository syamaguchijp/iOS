//
//  KeychainHelper.swift
//  SampleKeychain
//
//  Created by Yamaguchi on 2021/01/20.
//

import UIKit
import Foundation
import Security

let KhUserAccount = Bundle.main.bundleIdentifier
let KhSecClassValue = NSString(format: kSecClass)
let KhSecAttrAccountValue = NSString(format: kSecAttrAccount)
let KhSecValueDataValue = NSString(format: kSecValueData)
let KhSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let KhSecAttrServiceValue = NSString(format: kSecAttrService)
let KhSecMatchLimitValue = NSString(format: kSecMatchLimit)
let KhSecReturnDataValue = NSString(format: kSecReturnData)
let KhhecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)
let KhSecAttrAccessibleValue = NSString(format: kSecAttrAccessible)

class KeychainHelper: NSObject {

    /// キーチェーンに書き込む
    class func save(key: String, value: String?) {
        
        guard let value = value else {
            return
        }
        
        let dataFromString = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)! as NSData
        let keychainQuery = NSMutableDictionary(objects: [kSecAttrAccessibleAfterFirstUnlock, KhSecClassGenericPasswordValue, key, KhUserAccount!, dataFromString], forKeys: [KhSecAttrAccessibleValue, KhSecClassValue, KhSecAttrServiceValue, KhSecAttrAccountValue, KhSecValueDataValue])

        SecItemDelete(keychainQuery as CFDictionary)

        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    /// キーチェーンから読み込む
    /// キーチェーンの読み込みは1%位の確率で失敗することがある(Xcode7)ため、タプルによって、文字列とエラーコードをセットで返却するようにする
    /// @return tuple (string: String?, status: OSStatus)
    class func read(key: String) -> (value: String?, status: OSStatus) {
        
        let keychainQuery = NSMutableDictionary(objects: [KhSecClassGenericPasswordValue, key, KhUserAccount!, kCFBooleanTrue, KhhecMatchLimitOneValue], forKeys: [KhSecClassValue, KhSecAttrServiceValue, KhSecAttrAccountValue, KhSecReturnDataValue, KhSecMatchLimitValue])
        
        var dataTypeRef: AnyObject?
        var contentsOfKeychain: NSString? = nil
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
            }
        }

        return (contentsOfKeychain as String?, status)
    }
    
    /// キーチェーンから削除する
    class func delete(key: String) {
        
        let dataFromString = "".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)! as NSData
        let keychainQuery = NSMutableDictionary(objects: [KhSecClassGenericPasswordValue, key, KhUserAccount!, dataFromString], forKeys: [KhSecClassValue, KhSecAttrServiceValue, KhSecAttrAccountValue, KhSecValueDataValue])

        SecItemDelete(keychainQuery as CFDictionary)
    }
    
}
