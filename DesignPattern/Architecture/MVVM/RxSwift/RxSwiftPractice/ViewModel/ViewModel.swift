//
//  CounterRxViewModel.swift
//  RxSwiftPractice
//
//  Created by Yamaguchi on 2020/10/20.
//

import RxSwift
import RxCocoa

// ViewModel の役割
// * ViewとModelの仲介役
// * Viewに表示するためのデータを保持する
// * Viewからのイベントを受け取り、Modelの処理を呼び出したり、加工して値を更新する
// * Viewの参照は持たない
// * UIKitをimportしない

struct ViewModelInput {
    let buttonObservable: Observable<Void>
    let userNameTextFieldObservable: Observable<String?>
    let passwordTextFieldObservable: Observable<String?>
}

protocol ViewModelOutput {
    var labelText: Driver<String?> { get }
    var isIndicatorAnimating: Driver<Bool> { get }
    var isIndicatorHidden: Driver<Bool> { get }
}

class ViewModel {
    
    var output: ViewModelOutput?
    
    private let labelTextBehaviorRelay = BehaviorRelay<String>(value: "")
    private let indicatorAnimatingBehaviorRelay = BehaviorRelay<Bool>(value: false)
    private let indicatorHiddenBehaviorRelay = BehaviorRelay<Bool>(value: true)
    
    private let disposeBag = DisposeBag()
    private let userManager = UserManager()
    
    private var input: ViewModelInput?
    private var newUserName = ""
    private var newPassword = ""
    
    init(input: ViewModelInput) {
        
        self.output = self
        
        self.input = input
        
        input.buttonObservable
            .subscribe(onNext: {[weak self] in
                print("\(NSStringFromClass(type(of: self!))) \(#function)")
                self?.updateUser()
            })
            .disposed(by: disposeBag)
        
        input.userNameTextFieldObservable
            .subscribe { [weak self] in
                guard let value = $0.element else { return }
                print("\(NSStringFromClass(type(of: self!))) \(#function) value=\(String(describing: value))")
                self?.newUserName = value ?? ""
            }
            .disposed(by: disposeBag)
        
        input.passwordTextFieldObservable
            .subscribe { [weak self] in
                guard let value = $0.element else { return }
                print("\(NSStringFromClass(type(of: self!))) \(#function) value=\(String(describing: value))")
                self?.newPassword = value ?? ""
            }
            .disposed(by: disposeBag)
    }
    
    private func updateUser() {

        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let user = User.init()
        user.newUserName = newUserName
        user.newPassword = newPassword
        
        indicatorAnimatingBehaviorRelay.accept(true)
        indicatorHiddenBehaviorRelay.accept(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.userManager.updateUser(user: user, handler: {(user: User?, error: UserModelError?) in
                
                print("\(NSStringFromClass(type(of: self))) \(#function) handler")
                
                self.displayResultLabel(user: user, error: error)
                self.indicatorAnimatingBehaviorRelay.accept(false)
                self.indicatorHiddenBehaviorRelay.accept(true)
            })
        }
    }
    
    // updateUser の結果、画面下部のLabelを更新する
    private func displayResultLabel(user: User?, error: UserModelError?) {
        
        var labelString = "通信に不具合が発生しました"
        if error == UserModelError.invalidName {
            labelString = "名前の入力がありません"
        } else if error == UserModelError.invalidPassword {
            labelString = "パスワードの入力がありません"
        } else if let _ = user {
            labelString = "データ更新に成功しました"
        }
        
        labelTextBehaviorRelay.accept(labelString)
    }
}

extension ViewModel: ViewModelOutput {
    
    var labelText: Driver<String?> {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        return labelTextBehaviorRelay
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: nil)
    }
    
    var isIndicatorAnimating: Driver<Bool> {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        return indicatorAnimatingBehaviorRelay
            .map { $0 }
            .asDriver(onErrorJustReturn: true)
    }
    
    var isIndicatorHidden: Driver<Bool> {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        return indicatorHiddenBehaviorRelay
            .map { $0 }
            .asDriver(onErrorJustReturn: true)
    }
}
