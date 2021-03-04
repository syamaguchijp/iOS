import UIKit

// Protocolを実装したクラスを使い分け、アルゴリズムの切り替えを行う

protocol CarStrategy {
    func runMax()
}

class SkylineStrategy: CarStrategy {
    func runMax() {
        print("時速130kmで走る")
    }
}

class NBoxStrategy: CarStrategy {
    func runMax() {
        print("時速100kmで走る")
    }
}

class CarDriver {

    let strategy: CarStrategy

    init(strategy: CarStrategy) {
        self.strategy = strategy
    }
    
    func drive() {
        self.strategy.runMax()
    }
}

let driver = CarDriver.init(strategy: SkylineStrategy())
driver.drive()
