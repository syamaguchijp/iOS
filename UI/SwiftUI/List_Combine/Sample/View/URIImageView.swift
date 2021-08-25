//
//  URLImage.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

import SwiftUI

struct URIImageView: View {

    let url: String
    @ObservedObject private var uriImageDownload = URIImageDownload()

    init(url: String) {
        self.url = url
        uriImageDownload.execute(url: self.url)
    }

    var body: some View {
        
        if let imageData = uriImageDownload.data {
            let img = UIImage(data: imageData)
            return VStack {
                Image(uiImage: img!).resizable()
            }
        }
        else {
            return VStack {
                Image(systemName: "").resizable()
            }
        }
    }
}
