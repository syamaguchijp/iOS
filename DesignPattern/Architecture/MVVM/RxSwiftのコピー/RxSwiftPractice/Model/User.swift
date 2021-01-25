//
//  User.swift
//  RxSwiftPractice
//
//  Created by Yamaguchi on 2021/01/22.
//

import UIKit

class User: NSObject {

    static let shared = User()
    
    var currentWord: String?

    // シングルトン
    private override init() {
        super.init()
    }
}
