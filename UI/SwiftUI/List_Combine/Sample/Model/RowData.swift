//
//  RowData.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/24.
//

class RowData: Codable, Identifiable {
    
    var title: String
    var user: User
    struct User: Codable {
        var id: String
        var profile_image_url: String
    }
}
