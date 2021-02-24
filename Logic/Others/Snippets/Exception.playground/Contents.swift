import UIKit

// Structによる定義
struct HogeError: Error {
}

// Enumによる定義
enum FugaError: Error {
    case LowestValue
    case OverFlowValue
}

class Test {
    func test(x: Int) throws {
        if x <= 0 {
            throw FugaError.LowestValue
        } else if x >= 10000 {
            throw FugaError.OverFlowValue
        } else {
            throw HogeError()
        }
    }
}

let test = Test()

do {
    try test.test(x: -1)
    //try test.test(x: 10000)
    //try test.test(x: 100)

} catch FugaError.LowestValue {
    print("FugaError.LowestValue")
} catch FugaError.OverFlowValue {
    print("FugaError.OverFlowValue")
} catch is HogeError {
    print("HogeError")
} catch {
    print("Else")
}

// エラーが発生した場合に無視する時
try? test.test(x: -1)

// エラーが発生したらクラッシュ
try! test.test(x: -1)
