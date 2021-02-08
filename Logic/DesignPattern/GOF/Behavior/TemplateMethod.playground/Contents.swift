import UIKit

// Swiftは抽象クラスがないため、プロトコル拡張でTemplateMethod
protocol ComputerProtocol {
    func add()
    func multiply()
}

extension ComputerProtocol {
    func compute() {
        add()
        multiply()
    }
}

// プロトコルを実装した具象クラス
// プロトコルで定義された add と multiply の内容を実装する
struct ConcreteComputer: ComputerProtocol {
    func add() {
        print("1 + 1 = 2")
    }
    
    func multiply() {
        print("10 * 10 = 100")
    }
}

let computer = ConcreteComputer()
computer.compute()
