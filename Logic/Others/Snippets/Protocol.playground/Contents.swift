// デリゲートパターン

import UIKit

protocol SomeCallback: class {
    func didCallBack(number: Int)
}

class Callee {
    weak var callback: SomeCallback?

    func execute(){
        callback?.didCallBack(number: 1)
    }
}

// 呼び出し元
class Caller {
    var callee: Callee
    init(callee: Callee) {
        self.callee = callee
        self.callee.callback = self
    }
    func execute() {
        callee.execute()
    }
}
extension Caller: SomeCallback {
    func didCallBack(number: Int) {
        print("didCallBack!!!! \(number)")
    }
}

let caller = Caller(callee: Callee())
caller.execute()
