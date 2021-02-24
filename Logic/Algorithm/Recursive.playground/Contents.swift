import UIKit

// 再帰的アルゴリズム。ユークリッド互除法とハノイの塔

// ユークリッド互除法（最大公約数）
class Euclid {
    func mutiualDivision(x: Int, y: Int) -> Int {
        if y == 0 {
            return x
        }
        return mutiualDivision(x: y, y: x%y)
    }
}

// ハノイの塔
class TowerOfHanoi {
    // x軸からy軸へ円盤numを移動する
    func move(num: Int, x: Int, y: Int) {
        if num > 1 {
            move(num: num-1, x: x, y: 6-x-y)
        }
        print("\(x)軸から\(y)軸へ円盤\(num)を移動した。")
        if num > 1 {
            move(num: num-1, x: 6-x-y, y: y)
        }
    }
}

print(Euclid().mutiualDivision(x: 21, y: 12))

TowerOfHanoi().move(num: 3, x: 1, y: 3)
