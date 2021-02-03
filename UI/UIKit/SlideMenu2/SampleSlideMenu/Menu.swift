//
//  Menu.swift
//  SampleSlideMenu
//
//  Copyright © 2021 Yamaguchi. All rights reserved.
//

import UIKit

class Menu: NSObject {

    var title = ""
    var url = ""
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
