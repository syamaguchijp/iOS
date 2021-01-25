//
//  CounterRxViewModel.swift
//  RxSwiftPractice
//
//  Created by Yamaguchi on 2020/10/20.
//

import UIKit
import RxSwift
import RxCocoa


struct ViewModelInput {
    let button: Observable<Void>
    let textField: Observable<void>
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
    
    private let countRelay = BehaviorRelay<Int>(value: 0)
    
    private let initialCount = 0
    private let disposeBag = DisposeBag()
    
    init() {
        self.outputs = self
        resetCount()
    }
    
    func setup(input: ViewModelInput, binder: Binder<String?>) {
        
        input.button
            .subscribe(onNext: {[weak self] in
                self?.incrementCount()
            })
            .disposed(by: disposeBag)

        input.textField
            .subscribe(onNext: {[weak self] in
                self?.incrementCount()
            })
            .disposed(by: disposeBag)
        
        outputs?.labelText
            .drive(binder)
            .disposed(by: disposeBag)
    }
    
    private func incrementCount() {
        
        let count = countRelay.value + 1
        countRelay.accept(count)
    }
    
}

extension ViewModel: ViewModelOutput {
    
    var labelText: Driver<String?> {
        return countRelay
            .map { "Rx パターン:\($0)" }
            .asDriver(onErrorJustReturn: nil)
    }
}
