import UIKit

class Sample {

    func methodA(h: String?) {
        var hoge = h // <- because h is read-only

        //hoge = hoge.uppercased() // <- これはコンパイルエラーとなる
        //hoge = hoge!.uppercased() // <- nullの時にクラッシュする（強制アンラップ）。推奨はされない
        hoge = hoge?.uppercased() // <- これだとnullの時でもクラッシュせず何も起こらない（オプショナルチェイニング(Kotlinにおけるセーフコール)）

        // オプショナルバインディング（nilチェック）
        if let hoge = hoge {
            // このブロック内では、?や!!をつけずにhogeにアクセスできる
            print("hoge=\(hoge.uppercased())")
        } else {
            // nilのとき
            print("hoge is null.")
        }
        
        // guard文
        guard let fuga = hoge else {
            // nilのとき
            print("hoge is null, so return.")
            return
        }
        print("after guard, fuga=\(fuga.lowercased())")
    }
    
    func methodB(person: Person?) {
        if let p = person { // 参照を渡しているため、p.nameを変えると呼び出し元も変わる
            p.name = "Yamaha"
            print("p.name=\(p.name)")
        }
    }
    
    func methodC(person: Person?) {
        if var p = person {
            p = Person(name: "Kawasaki") // pには他のオブジェクトを参照させるため、呼び出し元には影響しない
            print("p.name=\(p.name)")
        }
    }
    
    func methodD(person: Person?) {
        guard var p = person else { // 参照を渡しているため、p.nameを変えると呼び出し元も変わる
            return
        }
        p.name = "Suzuki"
        print("p.name=\(p.name)")
    }
    
    func methodE(person: Person?) {
        guard var p = person else {
            return
        }
        p = Person(name: "Kawasaki") // pには他のオブジェクトを参照させるため、呼び出し元には影響しない
        print("p.name=\(p.name)")
    }
}

class Person {
    var name: String = ""
    init(name: String) {
        self.name = name
    }
}

Sample().methodA(h: nil)
print("------------")
Sample().methodA(h: "honda")
print("------------")
var person = Person(name: "Honda")
Sample().methodE(person: person)
print("person.name=\(person.name)")

