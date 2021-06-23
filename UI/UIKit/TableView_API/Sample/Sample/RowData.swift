//
//  RowData.swift
//  Sample
//
//  Created by Yamaguchi on 2021/06/23.
//

import UIKit

struct RowData: Codable {
    
    var title: String
    var user: User
    struct User: Codable {
        var id: String
        var profile_image_url: String
    }
}
