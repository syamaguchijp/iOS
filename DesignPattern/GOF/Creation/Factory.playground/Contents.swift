import UIKit

protocol User {
    var appendix: String { get }
    func payBill(payment: Int) -> Int
}

class NormalUser: User {
    var appendix: String {
        return "通常会員"
    }
    func payBill(payment: Int) -> Int {
        return Int(Double(payment) * 1.10)
    }
}

class SpecialUser: User {
    var appendix: String {
        return "特別会員"
    }
    func payBill(payment: Int) -> Int {
        return Int(Double(payment) * 0.90)
    }
}

// 生成するオブジェクトを条件に応じて切り替える
class UserFactory {
    
    class func createUser(age: Int) -> User {
        
        if age >= 50 {
            return SpecialUser()
        }
        
        return NormalUser()
    }
}

UserFactory.createUser(age: 49)

UserFactory.createUser(age: 50)
