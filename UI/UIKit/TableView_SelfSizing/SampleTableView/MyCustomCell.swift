//
//  MyCustomCell.swift
//  SampleTableView
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    // セルが再利用される前にコールされる
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        
        
    }
}
