import UIKit

// オブジェクトの状態を保存するパターン
// 状態の復元などに役立つ
class User {
    var name: String
    var currentScore: Int
    init(name: String, currentScore: Int) {
        self.name = name
        self.currentScore = currentScore
    }
    // メメントに保存
    func save() -> UserMemento {
        return UserMemento(score: currentScore)
    }
    // 復元
    func restore(memento: UserMemento) {
        self.currentScore = memento.score
        print("\(memento.score)に戻しました")
    }
}

// Userの状態を保持するメメント
class UserMemento {
    var score: Int
    var date: Date
    init(score: Int) {
        self.score = score
        date = Date()
    }
}

let user1 = User.init(name: "AAAA1", currentScore: 90)
let memento = user1.save() // 値の保存
user1.currentScore = 50 // 値の変更
user1.restore(memento: memento) // 値の復元

