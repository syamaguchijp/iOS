import UIKit

// 普段は代理人Proxyが働き、Proxyではできない内容の動作においては本人が登場する

protocol User {
    func doNormalWork()
    func doHardWork()
}

// 本人
class Person: User {
    func doNormalWork() {
        print("Person doNormalWork")
    }
    func doHardWork() {
        print("Person doHardWork")
    }
}

// 代理人（Proxy）
class PersonProxy: User {
    private var person: Person?
    func doNormalWork() {
        print("PersonProxy doNormalWork")
    }
    func doHardWork() {
        // ハードな仕事は本人でないと出来ないためここで本人を呼ぶ
        if let person = person {
            person.doHardWork()
            return
        }
        person = Person()
        person!.doHardWork()
    }
}

let proxy = PersonProxy()
proxy.doNormalWork()
proxy.doHardWork()

