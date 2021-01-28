import UIKit

// 総当り作成
class RoundRobin: NSObject {
    
    static func makeRoundRobin(array: [Int]) -> [[Int]] {
        
        let totalIndex = array.count
        var pow = totalIndex
        for _ in 1..<totalIndex {
            pow = pow * totalIndex
        }
        
        var array = [[Int]]()
        
        var initialRow = [Int]()
        for _ in 0..<totalIndex {
            initialRow.append(0)
        }
        
        for i in 0..<pow {
            guard let newArray = RoundRobin.makeArray(currentRowNum: i, lastRow: initialRow) else {
                continue
            }
            array.append(newArray)
        }
        return array
    }
    
    static func makeArray(currentRowNum: Int, lastRow: [Int]) -> [Int]? {
        
        let totalIndexs = lastRow.count
        var newRow = [Int]()
        for _ in 0..<totalIndexs {
            newRow.append(0)
        }
        
        var shou = currentRowNum
        var amari = currentRowNum
        for i in 0..<totalIndexs {
            amari = shou % totalIndexs
            shou = shou / totalIndexs
            newRow[totalIndexs - i - 1] = amari
            newRow[totalIndexs - i - 2] = shou
            if (shou < totalIndexs) {
                break
            }
        }
        
        var pow = totalIndexs
        for _ in 1..<totalIndexs {
            pow = pow * totalIndexs
        }
        
        if currentRowNum < pow && RoundRobin.hasSameValue(array: newRow) == false {
            return newRow
        }
        
        return nil
    }

    static func hasSameValue(array: [Int]) -> Bool {
        
        for i in 0..<array.count {
            if let index = array.index(of: array[i]) {
                if index != i {
                    return true
                }
            }
        }
        return false
    }
}

let answer = RoundRobin.makeRoundRobin(array: [0, 1, 2, 3])
print(answer)

