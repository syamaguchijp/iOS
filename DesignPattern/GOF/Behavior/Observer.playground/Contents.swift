import UIKit

class Observer {
    func didChangeState() {
        print("didChangeState!")
    }
}

protocol ViewModel {
    func addObserver(observer: Observer)
    func notifyObservers()
    func changeState()
}

class MyViewModel: ViewModel {
    var observers:[Observer] = []
    func addObserver(observer: Observer) {
        observers.append(observer)
    }
    func notifyObservers() {
        for i in observers {
            i.didChangeState()
        }
    }
    func changeState() {
        notifyObservers()
    }
}

var viewModel = MyViewModel()
var observer = Observer()
viewModel.addObserver(observer: observer)


viewModel.changeState()
