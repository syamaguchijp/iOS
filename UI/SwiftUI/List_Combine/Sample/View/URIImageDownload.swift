//
//  URIImageDownload.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

import Foundation

class URIImageDownload : ObservableObject {
    
    @Published var data: Data? = nil

    func execute(url: String) {

        guard let imageURL = URL(string: url) else {
            return
        }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
