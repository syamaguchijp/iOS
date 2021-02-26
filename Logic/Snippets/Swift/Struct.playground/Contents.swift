import UIKit

// 構造体は参照型ではなく値型。継承も出来ないことに注意
struct Person {
    var name: String
    var age: Int
    var isMale: Bool
    var school: String?
    func multyply(num: Int) -> Int {
        return num * 2
    }
    // 自身の値を変更する場合はmutatingキーワードを付加する
    mutating func multyplyAge() {
        self.age *= 2
    }
}

let person = Person(name: "Yamaguchi", age: 20, isMale: true) // <- 引数にオプショナル型（上記例のschool）は不要
print("\(person.name)")
// person.name = "ABC" <- personをvarで宣言しないとこれはコンパイルエラーとなる。クラス（参照型）との違いはココ。


class PersonClass {
    var name: String = ""
}

class Test {
    func methodA(person: Person) -> Person {
        // person.name = "Takeda" <- 構造体ではこれはコンパイルエラー
        var person2 = person // コピーを作成
        person2.name = "Takeda"
        return person2
    }
    func methodB(personClass: PersonClass) -> PersonClass {
        personClass.name = "Takeda" // クラスは参照型なのでこれでOK
        return personClass
    }
}
