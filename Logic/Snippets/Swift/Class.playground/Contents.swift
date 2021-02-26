import UIKit

class ClassSample: NSObject {

    // ストアドプロパティ
    var myString: String
    var myStringOptional: String?
    
    // デフォルトイニシャライザ
    // イニシャライザが1つも定義されておらず、すべてのプロパティの初期値が設定されている時に利用可能になる
    /*
    override init() {
        myString = "init"
        print("\(myString)")
    }*/
    
    // フェイラブルイニシャライザ
    init?(str: String?) {
        guard let str = str else {
            return nil
        }
        self.myString = str
        // myStringOptionalのほうは初期化する必要はない
    }
    
    // 指定イニシャライザ（インスタンスの初期化を全て完了する）
    init(str: String) {
        self.myString = str
    }
    
    // 簡易イニシャライザ（同じクラスの他のイニシャライザを呼び出して利用する）
    convenience override init() {
        self.init(str: "1234")
        //self.init() // こっちでもよい
    }
    
    // inoutで参照渡し
    convenience init(str: String, hoge: inout String) {
        hoge = hoge + "aaaa"
        print("hoge = \(hoge)")
        self.init(str: str)
    }
    
    // コンピューテッドプロパティ
    // getterの定義は任意だが、setterの定義は必須
    var myName: String? {
        get {
            return UserDefaults.standard.string(forKey: "myName")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "myName")
            UserDefaults.standard.synchronize()
        }
    }
    
    // ストアドプロパティ　プロバティオブザーバ
    var myStringObserved = "" {
        willSet {
            print("WillSet \(newValue)")
        }
        didSet {
            print("didSet \(self.myStringObserved)")
        }
    }
    
    // メソッド
    func multiply(_ num: Int) -> Int {
        // num = num * 2 // 再代入不可
        return num * 2
    }
    
    // スタティックプロパティ
    static let hoge1 = 123
    static var hoge2 = "Tokyo"
    // スタティックメソッド
    static func staticMethod(name: String) {
    }
}

// 継承
class ClassSample2: ClassSample {
    override func multiply(_ num: Int) -> Int {
        return super.multiply(num)
    }
}


var classSample = ClassSample.init(str: "yamaguchi")
print("myString = \(classSample.myString)")
classSample.myName = "taro"
print("myName = \(String(describing: classSample.myName))")
classSample.myStringObserved = "あいうえお"
print("myStringObserved = \(classSample.myStringObserved)")

var hoge = "BBBB"
classSample = ClassSample.init(str: "yamaguchi", hoge: &hoge) // &で参照渡し

var classSample2 = ClassSample2.init(str: "yamaguchi")
print("classSample2.multiply = \(classSample2.multiply(5))")

