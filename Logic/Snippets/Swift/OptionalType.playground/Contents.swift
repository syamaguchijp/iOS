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
}

Sample().methodA(h: nil)
print("------------")
Sample().methodA(h: "honda")

