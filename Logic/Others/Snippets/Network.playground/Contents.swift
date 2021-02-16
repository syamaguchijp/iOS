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
    
    /// URLSession POST
    func postUrlSession(urlString: String, parameter: String?) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        if let parameter = parameter {
            request.httpBody = parameter.data(using: String.Encoding.utf8)
        }
        
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

extension NetworkManager: URLSessionDownloadDelegate {
    
    // MARK: Download
    
    /// URLSession download
    func downloadImage(url urlString: String) -> Void {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let url = URL(string: urlString)!
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration,
                                 delegate: self,
                                 delegateQueue: OperationQueue.main)
        let task = session.downloadTask(with: url)
        task.resume()
        
        /*
        session.downloadTask(with: url, completionHandler: { (success, response, error) in
             if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
             } else {
             }
             session.invalidateAndCancel()
             
         }).resume()
         */
    }
    
    // ダウンロード進捗
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) \(Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        session.invalidateAndCancel()
        
        do {
            let data = try Data(contentsOf: location)
            _ = UIImage(data: data)
        } catch {
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        session.invalidateAndCancel()
    }
}

NetworkManager.init().getUrlSession(
    urlString: "https://httpbin.org/get",
    queryItems: [URLQueryItem(name: "a", value: "foo"), URLQueryItem(name: "b", value: "1234")])

/*
NetworkManager.init().postUrlSession(
    urlString: "https://httpbin.org/post",
    parameter: "a=foo&b=1234")
*/

//NetworkManager.init().downloadImage(url: "https://httpbin.org/image/png")
