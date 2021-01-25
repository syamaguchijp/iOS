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
    let textFieldObservable: Observable<String?>
}

protocol ViewModelOutput {
    var labelText: Driver<String?> { get }
}

protocol ViewModelType {
    var outputs: ViewModelOutput? { get }
    func setup(input: ViewModelInput, binder: Binder<String?>)
}

class ViewModel: ViewModelType {

    var outputs: ViewModelOutput?
    
    private let behaviorRelay = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    
    private var input: ViewModelInput?
    private var currentString = ""
    
    init() {
        self.outputs = self
    }
    
    func setup(input: ViewModelInput, binder: Binder<String?>) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        self.input = input
        
        input.buttonObservable
            .subscribe(onNext: {[weak self] in
                print("\(NSStringFromClass(type(of: self!))) \(#function)")
                self?.updateText()
            })
            .disposed(by: disposeBag)
        
        input.textFieldObservable
            .subscribe { [weak self] in
                guard let value = $0.element else { return }
                print("\(NSStringFromClass(type(of: self!))) \(#function) value=\(String(describing: value))")
                self?.currentString = value ?? ""
            }
            .disposed(by: disposeBag)
        
        outputs?.labelText
            .drive(binder)
            .disposed(by: disposeBag)
    }
    
    private func updateText() {

        behaviorRelay.accept(currentString)
    }
    
}

extension ViewModel: ViewModelOutput {
    
    var labelText: Driver<String?> {
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        return behaviorRelay
            .map { "\($0)" }
            .asDriver(onErrorJustReturn: nil)
    }
}
