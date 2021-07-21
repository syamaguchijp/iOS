//
//  CellData.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/21.
//

import UIKit

struct CellData: Codable {
    
    var title: String
    var user: User
    struct User: Codable {
        var id: String
        var profile_image_url: String
    }
}
