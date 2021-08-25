//
//  ApiManager.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

import Foundation
import Combine

class ApiManager: NSObject {
    
    func retrieveData() -> AnyPublisher<[RowData], Error> {
        
        print("\(String(describing: type(of: self))) \(#function)")
        
        let urlString = "https://qiita.com/api/v2/items"
        let queryItems = [URLQueryItem(name: "per_page", value: "50")]
        
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
            // mapでレスポンスデータのストリーム[RowData]に変換
            .map({ $0.data })
            .mapError { _ in RequestError.mapping(description: "mappping error") }
            // JSONからオブジェクトに変換
            .decode(type: [RowData].self, decoder: JSONDecoder())
            // ストリームをメインスレッドに流れるよう変換
            .receive(on: RunLoop.main)
            // Publisherの型を消去
            .eraseToAnyPublisher()
    }
}
