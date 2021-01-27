//
//  Presenter.swift
//  SampleMVP
//
//  Created by Yamaguchi on 2021/01/27.
//

// * プレゼンテーションロジックを処理する
// * Viewに描画指示を出す（デリゲート）

import UIKit

// Viewからの画面操作時
protocol PresenterInput {
    func updateUser(userName: String?, password: String?)
}

// Viewへのデリゲート
protocol PresenterOutput {
    func changeIndicator(isAnimating: Bool)
    func changeResultLabel(string: String)
    func changeResultLabelColor(color: UIColor)
}

class Presenter: PresenterInput {
    
    var delegate: PresenterOutput?
    
    private let userManager = UserManager()
    
    func updateUser(userName: String?, password: String?) {

        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let user = User.init()
        user.newUserName = userName
        user.newPassword = password
        
        delegate?.changeIndicator(isAnimating: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // インジケータの状態を確認するため1秒遅延処理
            
            self.userManager.updateUser(user: user, handler: {(user: User?, error: UserModelError?) in
                
                print("\(NSStringFromClass(type(of: self))) \(#function) handler")
                
                self.delegate?.changeIndicator(isAnimating: false)
                
                self.displayResultLabel(user: user, error: error)
            })
        }
    }
    
    private func displayResultLabel(user: User?, error: UserModelError?) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        var labelString = "通信に不具合が発生しました"
        var labelColor = UIColor.red
        
        if error == UserModelError.invalidName {
            labelString = "名前の入力がありません"
        } else if error == UserModelError.invalidPassword {
            labelString = "パスワードの入力がありません"
        } else if let _ = user {
            labelString = "データ更新に成功しました"
            labelColor = UIColor.black
        }
        
        self.delegate?.changeResultLabel(string: labelString)
        self.delegate?.changeResultLabelColor(color: labelColor)
    }
}
