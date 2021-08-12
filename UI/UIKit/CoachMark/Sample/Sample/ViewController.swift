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
        
        // コーチマークを表示する
        let message = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit"
        balloonViewManager.generate(baseView: view, targetView: label, labelText: message,
                                    color: .blue, horizontal: BalloonViewHorizontal.CENTER,
                                    vertical: BalloonViewVertical.TOP)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBalloonView))
        balloonViewManager.baloonView?.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func didTapBalloonView() {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        // コーチマークを終了する
        balloonViewManager.kill()
    }

}

