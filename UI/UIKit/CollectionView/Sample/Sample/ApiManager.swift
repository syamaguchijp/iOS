//
//  ApiManager.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/21.
//

import UIKit

class ApiManager: NSObject {

    func retrieveData(completion: @escaping ([CellData]) -> Void) {

        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let urlString = "https://qiita.com/api/v2/items"
        
        var compnents = URLComponents(string: urlString)
        compnents?.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
        ]
        guard let url = compnents?.url else {
            completion([])
            return
        }
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard  let data = data, let response = response else {
                completion([])
                return
            }
            print("\(NSStringFromClass(type(of: self))) \(#function) response=\(response)")
            
            do {
                let rowDataArray = try JSONDecoder().decode([CellData].self, from: data)
                completion(rowDataArray)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
