//
//  UserDefaultManager.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/22.
//

import Foundation
import UIKit

class UserDefaultsManager: NSObject {
    
    static let shared = UserDefaultsManager()

    private let ud = UserDefaults(suiteName: "group.com.yama.Sample.test")!
    private let KeyForMemo = "KeyForMemo"
    
    private override init() {
        super.init()
    }

    var memo: String? {
        get {
            return ud.string(forKey: KeyForMemo)
        }
        set(userName) {
            ud.set(userName, forKey: KeyForMemo)
            ud.synchronize()
        }
    }
}
