import UIKit

// 後入れ先出し（LIFO）を実現するスタック
class IntStack {

    var max: Int
    var pointer = 0
    var stack: Array<Int?>

    init(max: Int) {
        self.max = max
        stack = Array(repeating: nil, count: max)
    }

    // スタックに値をプッシュする
    func push(x: Int) throws {
        if pointer >= max {
            throw OverFlowStackError()
        } else {
            print("push \(x) to \(pointer)")
            stack[pointer] = x
            pointer += 1
        }
    }

    // スタックからデータをポップする
    func pop() throws -> Int? {
        if pointer <= 0 {
            throw EmptyStackError()
        } else {
            pointer -= 1
            print("pop \(String(describing: stack[pointer]))")
            return stack[pointer]
        }
    }
}

struct EmptyStackError: Error {
}

struct OverFlowStackError: Error {
}

let stack = IntStack(max: 3)
do {
    try stack.push(x: 10)
    try stack.push(x: 20)
    try stack.push(x: 30)
    try stack.pop()
    try stack.pop()
    try stack.pop()
} catch is EmptyStackError {
    print("EmptyStackError")
} catch is OverFlowStackError {
    print("OverFlowStackError")
} catch {
    print("Other")
}

