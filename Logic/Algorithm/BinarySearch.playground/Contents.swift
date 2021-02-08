import UIKit

// 二分探索
class BinarySearch: NSObject {
    
    /// @param searchNumber 探索する数値
    /// @param array 昇順にソートされていることが前提
    /// @return 配列に存在しない場合はnilを返却する。存在する場合は配列の該当indexを返却する。
    static func search(searchNumber: Int, array:[Int]) -> Int? {
        
        var minIndex = 0
        var maxIndex =  array.count - 1
        
        while minIndex <= maxIndex {
            let midIndex = (minIndex + maxIndex) / 2
            if array[midIndex] == searchNumber {
                return midIndex
            } else if array[midIndex] > searchNumber {
                maxIndex = midIndex - 1
            } else {
                minIndex = midIndex + 1
            }
        }
        
        return nil
    }
}

let answer1 = BinarySearch.search(searchNumber: 99, array: ([Int])(0..<100))
if let answer1 = answer1 {
    print(answer1)
}

