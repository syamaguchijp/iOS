import UIKit

// リソースを節約して軽量化するため、インスタンスを無駄に生成しないパターン

class Car {
    var color: UIColor
    init(color: UIColor) {
        self.color = color
    }
    func run() {
        print("run")
    }
}

class CarFactory {
    private var cars = [UIColor: Car]()
    func getCar(color: UIColor) -> Car {
        if let car = cars[color] {
            // すでに存在する場合はインスタンスを生成せずに再利用する
            return car
        }
        let car = Car.init(color: color)
        cars[color] = car
        return car
    }
}

let carFactory = CarFactory()
let car = carFactory.getCar(color: .red)
car.run()
