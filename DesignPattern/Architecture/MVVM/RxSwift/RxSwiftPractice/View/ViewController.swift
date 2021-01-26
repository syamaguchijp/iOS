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

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField! // UserName
    @IBOutlet weak var textField2: UITextField! // Password
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: ViewModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViewModel()
    }

    private func setupViewModel() {
        
        viewModel = ViewModel()
        
        let input = ViewModelInput(
            buttonObservable: button.rx.tap.asObservable(),
            userNameTextFieldObservable: textField.rx.text.asObservable(),
            passwordTextFieldObservable: textField2.rx.text.asObservable()
        )
        
        let binder = ViewModelBinder(
            labelText: label.rx.text,
            isIndicatorAnimating: indicator.rx.isAnimating,
            isIndicatorHidden: indicator.rx.isHidden
        )
     
        viewModel.setup(input: input, binder: binder)
    }
}

