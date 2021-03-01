import UIKit

// クロージャ
var closure: (Int) -> Int // 宣言
closure = { (x: Int) -> Int in
  x * 2
}
closure(10) // 実行


// Objective-Cにおけるtypedef
typealias MyCompletionClosure = (Bool, String) -> Void

class User {
    func executeClosure(completion: MyCompletionClosure) {
        print("executeClosure")
        completion(true, "NO_ERROR")
    }
}

let user = User.init()
user.executeClosure(completion: { (isSuccess: Bool, errorCode: String) -> Void in
    print("complete!!! \(isSuccess)")
})
