//
//  TabCollectionViewCell.swift
//  SampleTopTab
//
//  Created by Yamaguchi on 2021/01/13.
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

        /*
        self.layer.borderWidth = 1.0

        self.layer.borderColor = UIColor.black.cgColor

        self.layer.cornerRadius = 5.0
        */
        
    }
    
    func select(isSelected: Bool) {
        
        indicatorView.isHidden = !isSelected
    }
}
