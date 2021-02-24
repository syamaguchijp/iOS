import UIKit

// 先入れ先出し（FIFO）を実現するキュー。リングバッファ
class IntQueue {

    var max: Int
    var frontIndex = 0 // 先頭要素のインデックス
    var rearIndex = 0 // 末尾要素のインデックス
    var num = 0 // キューに蓄えられているデータ数
    var queue: Array<Int?>

    init(max: Int) {
        self.max = max
        queue = Array(repeating: nil, count: max)
    }

    func enqueue(x: Int) throws {

        if num >= max {
            throw OverFlowQueueError()
            
        } else {
            print("queue \(x) to \(rearIndex)")
            queue[rearIndex] = x
            rearIndex += 1
            num += 1
            if rearIndex == max {
                // リングバッファのため、一回転してrearIndexは配列の先頭へ。
                rearIndex = 0
            }
        }
    }

    func dequeue() throws -> Int? {

        if num <= 0 {
            throw EmptyQueueError()
        }
        
        let x = queue[frontIndex]
        frontIndex += 1
        num -= 1
        if frontIndex == max {
            // リングバッファのため、一回転してfrontIndexは配列の先頭へ。
            frontIndex = 0
        }
        print("dequeue \(String(describing: x))")
        return x
    }
}

struct EmptyQueueError: Error {
}

struct OverFlowQueueError: Error {
}

let queue = IntQueue(max: 3)
do {
    try queue.enqueue(x: 10)
    try queue.enqueue(x: 20)
    try queue.enqueue(x: 30)
    try queue.dequeue()
    try queue.dequeue()
    try queue.dequeue()
} catch is EmptyQueueError {
    print("EmptyQueueError")
} catch is OverFlowQueueError {
    print("OverFlowQueueError")
} catch {
    print("Other")
}
