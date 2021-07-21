//
//  MyCollectionViewCell.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/21.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    static var identifier: String {String(describing: self)}
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.awakeFromNib()
    }
    
    /*
    override init(frame: CGRect) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }*/

    // セルが再利用される前にコールされる
    override func prepareForReuse() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.prepareForReuse()
        
        imageView.image = nil
        label.text = ""
    }
    
    func setText(_ text: String?) {
        
        label?.text = text
    }
    
    func setImage(_ ulrStr: String?) {
        
        guard let ulrStr = ulrStr else {
            return
        }
        let url = URL(string: ulrStr)
        do {
            let imageData = try Data(contentsOf: url!)
            imageView?.image = UIImage(data: imageData)
        } catch {
        }
    }
}
