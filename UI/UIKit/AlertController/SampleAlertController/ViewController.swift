//
//  ViewController.swift
//  SampleAlertController
//
//  Created by admin on 2017/12/10.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.showAlertWithInputText()
        //self.showAlert()
    }

    func showAlert() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let alertController = UIAlertController(title: "test", message: "アラート", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {(action: UIAlertAction) -> Void  in
            print("\(NSStringFromClass(type(of: self))) \(#function) OK")
        }
        alertController.addAction(okAction)
        
        let cancelButton = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // テキストフィールド付きアラートを表示する
    func showAlertWithInputText() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action:UIAlertAction!) -> Void in
            // OKを押した時入力されていたテキストを表示
            if let textFields = alert.textFields {
                // アラートに含まれるすべてのテキストフィールドを調べる
                for textField in textFields {
                    print(textField.text!)
                }
            }
        })
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "テキストを入力してください"
        })
        
        // 複数追加したいならその数だけ書く
        // alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        //     textField.placeholder = "テキスト"
        // })
        
        //alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生

        self.present(alert, animated: true, completion: nil)
    }

}

