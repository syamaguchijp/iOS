//
//  UserManager.swift
//  RxSwiftPractice
//
//  Created by Yamaguchi on 2021/01/25.
//

import UIKit

class UserManager: NSObject {

    func updateUser(user: User, handler: @escaping (_ user: User?, _ error: UserModelError?) -> Void) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if !isValidUserName(userName: user.newUserName) {
            handler(nil, UserModelError.invalidName)
            return
        }
        if !isValidPassword(password: user.newPassword) {
            handler(nil, UserModelError.invalidPassword)
            return
        }
        
        let queryItems = [URLQueryItem(name: "userName", value: user.newUserName!),
                          URLQueryItem(name: "password", value: user.newPassword!)]
        
        let nm = NetworkManager.init()
        nm.getUrlSession(urlString: "https://httpbin.org/get", queryItems: queryItems, completion: {(resultJson: Any?) in
            
            print("\(NSStringFromClass(type(of: self))) \(#function) handler")
            
            guard let resultJson = resultJson else {
                handler(nil, UserModelError.networkError)
                return
            }
                   
            let jsonDict = resultJson as! NSDictionary
            let args = jsonDict["args"] as! NSDictionary
            user.userName = args["userName"] as? String
            user.password = args["password"] as? String
           
            handler(user, nil)
        })
    }
    
    private func isValidUserName(userName: String?) -> Bool {
        
        guard let userName = userName else {
            return false
        }
        
        if userName.count == 0 {
            return false
        }
        
        return true
    }
    
    private func isValidPassword(password: String?) -> Bool {
        
        guard let password = password else {
            return false
        }
        
        if password.count == 0 {
            return false
        }
        
        return true
    }
}
