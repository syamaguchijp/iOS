//
//  NetworkManager.swift
//  RxSwiftPractice
//
//  Created by Yamaguchi on 2021/01/22.
//

import UIKit

class NetworkManager: NSObject {

    /// URLSession GET
    func getUrlSession(urlString: String, queryItems: [URLQueryItem]) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        var compnents = URLComponents(string: urlString)
        compnents?.queryItems = queryItems
        guard let url = compnents?.url else {
            return
        }
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        //request.setValue("Content-Type", forHTTPHeaderField: "application/json")
        //request.setValue("User-Agent", forHTTPHeaderField: "")
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            session.invalidateAndCancel()
            guard  let data = data, let response = response else {
                return
            }
            print("\(NSStringFromClass(type(of: self))) \(#function) response=\(response)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                print("\(NSStringFromClass(type(of: self))) \(#function) json=\(json)")
            } catch {
            }
        })
        task.resume()
    }
}
