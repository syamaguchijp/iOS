//
//  ViewController.swift
//  SampleKeyboard
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let keyboardManager = KeyBoardManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textField1.delegate = self
        textField2.delegate = self
        
        keyboardManager.textFieldArray.append(textField1)
        keyboardManager.textFieldArray.append(textField2)
        keyboardManager.scrollView = scrollView
        keyboardManager.generateObserver()
        keyboardManager.superViewBufferY = CGFloat(20.0)
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        // このタイミングでないと、正しいSafeAreaは取得できない
        keyboardManager.safeAreaInsets = self.view.safeAreaInsets
    }
    
    // MARK: UITextFieldDelegate
    
    /// テキストフィールドをタップしたとき（キーボード出現の直前）にコールされる
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        keyboardManager.updateScrollTargetView = textField
        
        return true
    }
    
    /// テキストフィールド入力時にコールされる
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }

}

