//
//  ScrollViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/01.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.bounces = false
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) \(scrollView.contentOffset.y)")
        
        if scrollView.contentOffset.y < -120.0 {
            // over the topmost, close this view.
            print("\(NSStringFromClass(type(of: self))) \(#function) dismiss!")
            self.dismiss(animated: true, completion: nil)
        }
    }

}
