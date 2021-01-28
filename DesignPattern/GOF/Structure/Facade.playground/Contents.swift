import UIKit

// 窓口を作る。ユーザーデフォルトやキーチェーンなどの読み書きに利用
class UserDafaultManager {
    
    private let ud = UserDefaults.standard
    private let nameKey = "name"
    
    var name: String? {
        
        get {
            return ud.string(forKey: nameKey)
        }
        
        set(nickName) {
            ud.set(nickName, forKey: nameKey)
        }
    }
}

let ud = UserDafaultManager()
ud.name = "hoge"
print("\(ud.name)")
