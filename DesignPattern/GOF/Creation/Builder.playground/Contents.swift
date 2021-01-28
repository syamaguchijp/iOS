import UIKit

class User {
    
    let name: String
    let birthday: Date
    let age: Int
    let sports: String
    let religion: String
    
    // 呼び出し元がオブジェクトの設定データのデフォルト値などを知らなくても良いように、
    // 生成の際にオブジェクトの作成に必要なデータがイニシャライザにまとまっている
    init(name: String, birthday: Date, age: Int, sports: String, religion: String) {
        self.name = name
        self.birthday = birthday
        self.age = age
        self.sport = sports
        self.religion = religion
    }
}


