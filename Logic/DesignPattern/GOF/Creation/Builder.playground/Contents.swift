import UIKit

protocol Builder {
    func setName(name: String)
    func setBirthday(birthday: Date)
    func setAge(age: Int)
}

class UserBuilder: Builder {
    let user = User()
    func setName(name: String) {
        user.name = name
    }
    func setBirthday(birthday: Date) {
        user.birthday = birthday
    }
    func setAge(age: Int) {
        user.age = age
    }
}

class User {
    var name: String?
    var birthday: Date?
    var age: Int?
    /*
    // 呼び出し元がオブジェクトの設定データのデフォルト値などを知らなくても良いように、
    // 生成の際にオブジェクトの作成に必要なデータがイニシャライザにまとまっている
    init(name: String, birthday: Date, age: Int) {
        self.name = name
        self.birthday = birthday
        self.age = age
    }*/
    func dump() {
        print("name=\(String(describing: name)) age=\(String(describing: age)) birthday=\(String(describing: birthday))")
    }
}

// Directorを通じて、Builderがオブジェクトを段階的に組み上げていくパターン
class Director {
    let builder: Builder
    init(builder: Builder) {
        self.builder = builder
    }
    func build() {
        self.builder.setName(name: "Takeda")
        self.builder.setBirthday(birthday: Date())
        self.builder.setAge(age: 20)
    }
}

let builder = UserBuilder()
let director = Director(builder: builder)
director.build()
builder.user.dump()


