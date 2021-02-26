//
//  Util.swift
//  Utility
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

struct Util {
    
    // MARK: Date関連
    
    /// DateFormatterを返却する。ISO8601に準拠。
    /// @return DateFormatter yyyy-MM-dd'T'HH:mm:ssZ
    static func gregorianFormatterISO8601() -> DateFormatter {
        
        let formatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        formatter.calendar = calendar
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter
    }
    
    /// DateFormatterを返却する。yyyy/MM/dd 形式
    /// @return DateFormatter yyyy/MM/dd
    static func gregorianFormatterYYYYMMDD() -> DateFormatter {
        
        let formatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        formatter.calendar = calendar
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy/MM/dd"
        
        return formatter
    }
    
    /// DateFormatterを返却する。yyyy/MM/dd HH:mm 形式
    /// @return DateFormatter yyyy/MM/dd HH:mm
    static func gregorianFormatterYYYYMMDDHHMM() -> DateFormatter {
        
        let formatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        formatter.calendar = calendar
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return formatter
    }
    
    /// Dateからyyyy/MM/dd形式の文字列に変換する
    /// @return String yyyy/MM/dd形式
    static func generateYYYYMMDDString(date: Date) -> String? {
        
        let formatter = Util.gregorianFormatterYYYYMMDD()
        return formatter.string(from: date)
    }
    
    /// Dateからyyyy/MM/dd HH:mm 形式の文字列に変換する
    /// @return String yyyy/MM/dd HH:mm 形式
    static func generateYYYYMMDDHHMMString(date: Date) -> String? {
        
        let formatter = Util.gregorianFormatterYYYYMMDDHHMM()
        return formatter.string(from: date)
    }
    
    /// ISO8601形式の文字列から、yyyy/MM/dd形式の文字列に変換する
    /// @param iso8601String String ISO8601形式
    /// @return String yyyy/MM/dd形式
    static func convertToYYYYMMDDString(iso8601String: String) -> String? {
        
        let iso8601Formetter = Util.gregorianFormatterISO8601()
        guard let iso8601Date = iso8601Formetter.date(from: iso8601String) else {
            return nil
        }
        
        let yyyymmddFormatter = Util.gregorianFormatterYYYYMMDD()
        return yyyymmddFormatter.string(from: iso8601Date)
    }
    
    // MARK: 文字列関連
    
    /// URLエンコードを行う。
    /// @return URLエンコード化された文字列
    static func encodeUrl(urlString: String?) -> String? {
        
        let custom = CharacterSet(charactersIn: "!\"\n#$%&'()-=^~|@`[]{};+:*,<>./?_").inverted
        if let urlString = urlString, let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: custom) {
            return encodedString
        }
        return nil
    } 
    
    /// URLデコードを行う。
    /// @return URLデコード化された文字列
    static func decodeUrl(urlString: String?) -> String? {
        
        if let urlString = urlString, let decodedString = urlString.removingPercentEncoding {
            return decodedString
        }
        return nil
    }

}
