import UIKit

// 容器と中身を同一視し、再帰的な構造を作る
// 下記例では、Employee型とEmployee型を要素に構成される集合体(Company)も同じものとして扱えるようにする
protocol Member {
    var name: String { get }
    var score: Int { get }
    func dumpScore()
}

class Employee: Member {
    let name: String
    let score: Int
    func dumpScore() {
        print("\(name) => \(score)")
    }
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}

class Company: Member {
    let name: String
    let employees: [Employee]
    var score: Int {
        var sum = 0
        for emp in employees {
            sum += emp.score
        }
        return sum
    }
    func dumpScore() {
        print("\(name) => \(score)")
    }
    init(name: String, employees: [Employee]) {
        self.name = name
        self.employees = employees
    }
}

let employee1 = Employee(name: "aaaa", score: 1)
let employee2 = Employee(name: "bbbb", score: 2)
let employee3 = Employee(name: "cccc", score: 3)

let compamy = Company(name: "XXXX inc,", employees: [employee1, employee2, employee3])

// 以下のように従業員も会社も同じように扱える
employee1.dumpScore()
employee2.dumpScore()
employee3.dumpScore()
compamy.dumpScore()
