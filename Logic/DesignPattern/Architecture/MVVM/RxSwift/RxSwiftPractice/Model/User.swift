//
//  User.swift
//  RxSwiftPractice
//
//  Created by Yamaguchi on 2021/01/22.
//

import UIKit

enum UserModelError: Error {
    case invalidName
    case invalidPassword
    case networkError
}

class User: NSObject {

    //static let shared = User()
    
    var userName: String?
    var password: String?
    
    var newUserName: String?
    var newPassword: String?

    /*
    // シングルトン
    private override init() {
        super.init()
    }*/
    
}
