//
//  ApiManager.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

import Foundation
import Combine

class ApiManager: NSObject {
    
    func startUrlSession(name: String, password: String) -> AnyPublisher<ApiResponse, Error> {
        
        print("\(String(describing: type(of: self))) \(#function)")
        
        let urlString = "https://httpbin.org/get"
        let queryItems = [URLQueryItem(name: "userName", value: name),
                          URLQueryItem(name: "password", value: password)]
        
        var compnents = URLComponents(string: urlString)
        compnents?.queryItems = queryItems
        guard let url = compnents?.url else {
            let error = RequestError.parse(description: "url error")
            return Fail(error: error).eraseToAnyPublisher()
        }
        print("\(String(describing: type(of: self))) \(#function) \(url)")
            
        // URLSessionのPublisherを実行
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            // mapでレスポンスデータのストリームに変換
            .map({ $0.data })
            .mapError { _ in RequestError.mapping(description: "mappping error") }
            // JSONからオブジェクトに変換
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            // ストリームをメインスレッドに流れるよう変換
            .receive(on: RunLoop.main)
            // Publisherの型を消去
            .eraseToAnyPublisher()
    }
}
