//
//  UtilTests.swift
//  UtilityTests
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import XCTest

class UtilTests: XCTestCase {
    
    func testgenerateYYYYMMDDString() {
        
        let calendar = Calendar(identifier: .gregorian)
        var ansString: String?
        
        var date = calendar.date(from: DateComponents(year: 2017, month: 1, day: 1, hour: 0, minute: 0, second: 0))
        if let d = date {
            ansString = Util.generateYYYYMMDDString(date: d)
            XCTAssertEqual(ansString!, "2017/01/01")
        } else {
            XCTFail()
        }
        
        date = calendar.date(from: DateComponents(year: 2017, month: 1, day: 1, hour: 6, minute: 0, second: 0))
        if let d = date {
            ansString = Util.generateYYYYMMDDString(date: d)
            XCTAssertEqual(ansString!, "2017/01/01")
        } else {
            XCTFail()
        }
        
        date = calendar.date(from: DateComponents(year: 2017, month: 1, day: 1, hour: 12, minute: 0, second: 0))
        if let d = date {
            ansString = Util.generateYYYYMMDDString(date: d)
            XCTAssertEqual(ansString!, "2017/01/01")
        } else {
            XCTFail()
        }
        
        date = calendar.date(from: DateComponents(year: 2017, month: 1, day: 1, hour: 18, minute: 0, second: 0))
        if let d = date {
            ansString = Util.generateYYYYMMDDString(date: d)
            XCTAssertEqual(ansString!, "2017/01/01")
        } else {
            XCTFail()
        }
        
        date = calendar.date(from: DateComponents(year: 2017, month: 1, day: 1, hour: 23, minute: 59, second: 59))
        if let d = date {
            ansString = Util.generateYYYYMMDDString(date: d)
            XCTAssertEqual(ansString!, "2017/01/01")
        } else {
            XCTFail()
        }
    }
    
    func testConvertToYYYYMMDDString() {
        
        var ansString: String?
        
        ansString = Util.convertToYYYYMMDDString(iso8601String: "2018-07-24T00:00:00+09:00")
        XCTAssertEqual(ansString!, "2018/07/24")
        
        ansString = Util.convertToYYYYMMDDString(iso8601String: "2018-07-24T06:00:00+09:00")
        XCTAssertEqual(ansString!, "2018/07/24")
        
        ansString = Util.convertToYYYYMMDDString(iso8601String: "2018-07-24T12:00:00+09:00")
        XCTAssertEqual(ansString!, "2018/07/24")
        
        ansString = Util.convertToYYYYMMDDString(iso8601String: "2018-07-24T18:00:00+09:00")
        XCTAssertEqual(ansString!, "2018/07/24")
        
        ansString = Util.convertToYYYYMMDDString(iso8601String: "2018-07-24T23:59:59+09:00")
        XCTAssertEqual(ansString!, "2018/07/24")
    }
    
    func testeEncodeUrl() {
        
        var testString: String?
        var ansString: String?
        
        testString = "app=hoge&vendor=fuga"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "app%3Dhoge%26vendor%3Dfuga")
        
        testString = "!"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%21")
        
        testString = "\""
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%22")
        
        testString = "#"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%23")
        
        testString = "$"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%24")
        
        testString = "%"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%25")
        
        testString = "&"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%26")
        
        testString = "'"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%27")
        
        testString = "("
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%28")
        
        testString = ")"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%29")
        
        testString = "="
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%3D")
        
        testString = "|"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%7C")
        
        testString = "^"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%5E")
        
        testString = "¥"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%C2%A5")
        
        testString = "@"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%40")
        
        testString = "`"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%60")
        
        testString = "["
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%5B")
        
        testString = "{"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%7B")
        
        testString = ";"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%3B")
        
        testString = "+"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%2B")
        
        testString = ":"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%3A")
        
        testString = "*"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%2A")
        
        testString = "]"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%5D")
        
        testString = "}"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%7D")
        
        testString = ","
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%2C")
        
        testString = "<"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%3C")
        
        testString = ">"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%3E")
        
        testString = "/"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%2F")
        
        testString = "?"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%3F")
        
        testString = "_"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%5F")
        
        testString = "~"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%7E")
        
        testString = "-"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%2D")
        
        testString = "."
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%2E")
        
        testString = "あいうえおかきくけこ"
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A%E3%81%8B%E3%81%8D%E3%81%8F%E3%81%91%E3%81%93")
        
        testString = ""
        ansString = Util.encodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "")
        
        ansString = Util.encodeUrl(urlString: nil)
        XCTAssertNil(ansString)
    }
    
    func testeDecodeUrl() {
        
        var testString: String?
        var ansString: String?
        
        testString = "app%3Dhoge%26vendor%3Dfuga"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "app=hoge&vendor=fuga")
        
        testString = "%21"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "!")
        
        testString = "%22"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "\"")
        
        testString = "%23"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "#")
        
        testString = "%24"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "$")
        
        testString = "%25"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "%")
        
        testString = "%26"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "&")
        
        testString = "%27"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "'")
        
        testString = "%28"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "(")
        
        testString = "%29"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, ")")
        
        testString = "%3D"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "=")
        
        testString = "%7C"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "|")
        
        testString = "%5E"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "^")
        
        testString = "%C2%A5"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "¥")
        
        testString = "%40"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "@")
        
        testString = "%60"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "`")
        
        testString = "%5B"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "[")
        
        testString = "%7B"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "{")
        
        testString = "%3B"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, ";")
        
        testString = "%2B"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "+")
        
        testString = "%3A"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, ":")
        
        testString = "%2A"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "*")
        
        testString = "%5D"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "]")
        
        testString = "%7D"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "}")
        
        testString = "%2C"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, ",")
        
        testString = "%3C"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "<")
        
        testString = "%3E"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, ">")
        
        testString = "%2F"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "/")
        
        testString = "%3F"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "?")
        
        testString = "%5F"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "_")
        
        testString = "%7E"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "~")
        
        testString = "%2D"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "-")
        
        testString = "%2E"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, ".")
        
        testString = "%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A%E3%81%8B%E3%81%8D%E3%81%8F%E3%81%91%E3%81%93"
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "あいうえおかきくけこ")
        
        testString = ""
        ansString = Util.decodeUrl(urlString: testString!)
        XCTAssertEqual(ansString!, "")
        
        ansString = Util.decodeUrl(urlString: nil)
        XCTAssertNil(ansString)
    }
    
}
