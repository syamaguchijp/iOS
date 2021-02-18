// 値型と参照型についてのまとめ

import UIKit

// 値型
struct Robot {
    var name = ""
    var age = 0
}
// なお、Array、Dictionaryなども値型である

// 参照型
class Person {
    var name = ""
    var age = 0
}

class Test {
    
    // 値型
    
    // 値型の値渡し（Struct）
    func method1(robot: Robot) -> Robot {
        //robot.name = "Takeda" <- コンパイルエラー
        var ans = robot // 値型のためcopyされて別物となる
        ans.name = "Takeda"
        return ans
    }
    
    // 値型の参照渡し（Struct）
    func method2(robot: inout Robot) {
        robot.name = "Tajima"
    }

    // 値型の値渡し（Array）
    func method3(array: [String]) -> [String] {
        //ary[1] = "ZZZZ" <- コンパイルエラー
        var ans = array // 値型のためcopyされて別物となる
        ans[1] = "ZZZZ"
        return ans
    }
    
    // 値型の参照渡し（Array）
    func method4(array: inout [String]) {
        array[1] = "XXXX"
    }
    
    // 値型の値渡し（Dictionary）
    func method5(dict: [String: String]) -> [String: String] {
        //dict["b"] = "ZZZZ" //<- コンパイルエラー
        var ans = dict // 値型のためcopyされて別物となる
        ans["b"] = "ZZZZ"
        return ans
    }
    
    // 値型の参照渡し（Dictionary）
    func method6(dict: inout [String: String]) {
        dict["b"] = "XXXX"
    }
    
    // 値型の値渡し（String）
    func method7(str: String) -> String {
        //str = "XXX" //<- コンパイルエラー
        var ans = str // 値型のためcopyされて別物となる
        ans = "XXX"
        return ans
    }
    
    // 値型の参照渡し（String）
    func method8(str: inout String) {
        str = "YYY"
    }
    
    // 参照型
    
    // 参照型の値渡し
    func method10(person: Person) {
        person.name = "Yamada"
    }
    
    // 参照型の参照渡し
    func method11(person: inout Person) {
        person.name = "Takeda"
    }
}

let test = Test()

// 値型

var robot = Robot()
var robot2 = test.method1(robot: robot)
print("robot.name=\(robot.name)") // 引数で渡したものは変わっていない
print("robot2.name=\(robot2.name)")

var robot3 = Robot()
test.method2(robot: &robot3)
print("robot3.name=\(robot3.name)")

var robot4 = robot3 // 値型なのでコピーされるため、別物となる
robot4.name = "7777"
print("robot3.name=\(robot3.name)") // robot4に影響を受けない！
print("robot4.name=\(robot4.name)")

var myArray = ["AAA", "BBB", "CCC"]
let myArray2 = test.method3(array: myArray)
print("myArray[1]=\(myArray[1])") // 引数で渡したものは変わっていない
print("myArray2[1]=\(myArray2[1])")

var myArray3 = ["AAA", "BBB", "CCC"]
test.method4(array: &myArray3)
print("myArray3[1]=\(myArray3[1])")

var myDict = ["a": "AAA", "b": "BBB", "c": "CCC"]
let myDict2 = test.method5(dict: myDict)
print("myDict[b]=\(String(describing: myDict["b"]))") // 引数で渡したものは変わっていない
print("myDict2[b]=\(String(describing: myDict2["b"]))")

var myDict3 = ["a": "AAA", "b": "BBB", "c": "CCC"]
test.method6(dict: &myDict3)
print("myDict3[b]=\(String(describing: myDict3["b"]))")

var myStr = "Yamaha"
let myStr2 = test.method7(str: myStr)
print("myStr=\(myStr)") // 引数で渡したものは変わっていない
print("myStr2=\(myStr2)")

var myStr3 = "Honda"
test.method8(str: &myStr3)
print("myStr3=\(myStr3)")

// 参照型

let person = Person()
test.method10(person: person)
print("person.name=\(person.name)")
var person2 = Person()
test.method11(person: &person2)
print("person2.name=\(person2.name)")

let person3 = person // コピーされずに同じものの参照となる
person3.name = "Person3"
print("person.name=\(person.name)") // こちらも"Person3"となる
print("person3.name=\(person3.name)")
