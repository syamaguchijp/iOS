//
//  ViewController.swift
//  SampleMVP
//
//  Created by Yamaguchi on 2021/01/26.
//

import UIKit

// * ユーザーの入力をPresenterに伝える
// * 画面の描画処理を行う
// * Modelの参照は持たない

class ViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private let presenter = Presenter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter.delegate = self
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
        presenter.updateUser(userName: textField1.text, password: textField2.text)
    }
}

extension ViewController: PresenterOutput {
    
    func changeIndicator(isAnimating: Bool) {
        
        if (isAnimating) {
            indicatorView.startAnimating()
        } else {
            indicatorView.stopAnimating()
        }
        indicatorView.isHidden = !isAnimating
    }
    
    func changeResultLabel(string: String) {
        
        label.text = string
    }
    
    func changeResultLabelColor(color: UIColor) {
        
        label.textColor = color
    }
}

