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
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
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
            textFieldObservable: textField.rx.text.asObservable()
        )
        
        viewModel.setup(input: input, binder: label.rx.text)

    }
}

