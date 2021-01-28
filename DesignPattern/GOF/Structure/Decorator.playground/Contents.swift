import UIKit

class User {
    var name = "AAAA"
    func dumpName() {
        print("name = \(name)")
    }
}

// 既存クラス（User）を継承したり変更を加えたりすることなく、Userクラスの拡張を行う
class UserDecolator {
    let user = User()
    func dumpName() {
        print("name = \(user.name)様")
    }
}

User().dumpName()
UserDecolator().dumpName()
