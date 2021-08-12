//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    private let balloonViewManager = BalloonViewManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let message = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        balloonViewManager.generate(baseView: view, targetView: label, labelText: message,
                                    color: .blue, horizontal: BalloonViewHorizontal.RIGHT)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBalloonView))
        balloonViewManager.baloonView?.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func didTapBalloonView() {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        balloonViewManager.kill()
    }

}

