//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by Yamaguchi on 2020/10/12.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var appendixLabel: UILabel!
    
    @IBOutlet weak var doButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: ViewModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewModel()
    }

    private func setupViewModel() {
        
        viewModel = ViewModel()
        
        let input = ViewModelInput(
            button: button.rx.tap.asObservable(),
            textField: textField.rx.tap.asObservable()
        )
        
        viewModel.setup(input: input, binder: label.rx.text)

    }
}

