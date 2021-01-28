import UIKit

// 時間のかかる処理などを行った後の値を引き継いで、そのオブジェクトのコピーを作りたい場合などに用いる
class User: NSObject {
    
    var name: String
    var number = 0
    
    init(name: String = "") {
        self.name = name
    }
    
    // 時間のかかる処理
    func addNumber() {
        number = 0
        for _ in 1..<100000 {
            number += 1
        }
        print("\(number)")
    }

    // 自分自身の既存値をセットし、新しいインスタンスを生成する
    func clone() -> User {
        let cloneUser = User()
        cloneUser.name = self.name
        cloneUser.number = self.number
        return cloneUser
    }
}

let user1 = User.init(name: "ym")
user1.addNumber()

let user2 = user1.clone()

