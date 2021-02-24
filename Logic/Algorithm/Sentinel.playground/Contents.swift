import UIKit

// 線形探索　番兵法
class LinearSearch {

    // listからkeyと一致する要素を線形探索して、その要素番号を返却する
    static func search(array: [Int], key: Int) -> Int {

        var index = 0
        
        var ary = array
        ary.append(key) // 末尾に番兵を追加する

        while (true) {
            if array[index] == key {
                break
            }
            index += 1
        }
        if index == ary.count {
            return -1
        }
        return index
        
        /*
        // 番兵法を使わない場合
        while (true) {
            if index == ary.count { // このif文のコスト
                // 探索失敗のため-1を返却
                return -1
            }
            if ary[index] == key {
                return index
            }
            index += 1
        }*/
    }
}

print(LinearSearch.search(array: [0, 10, 5, 3, 8, 9, 7], key: 3))

