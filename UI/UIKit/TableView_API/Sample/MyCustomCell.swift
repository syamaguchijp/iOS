//
//  MyCustomCell.swift
//  Sample
//
//  Created by Yamaguchi on 2021/06/23.
//

import UIKit

class MyCustomCell: UITableViewCell {

    static var identifier: String {String(describing: self)}
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    // セルが再利用される前にコールされる
    override func prepareForReuse() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.prepareForReuse()
        
        myImageView.image = nil
        myLabel.text = ""
    }
}
