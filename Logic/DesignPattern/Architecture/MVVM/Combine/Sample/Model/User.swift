//
//  User.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

enum UserModelError: Error {
    case invalidName
    case invalidPassword
    case networkError
}

class ApiResponse: Codable {

    var userName: String?
    var password: String?
    
}
