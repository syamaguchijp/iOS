//
//  Errors.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

enum RequestError: Error {
    case parse(description: String)
    case mapping(description: String)
    case network(description: String)
}
