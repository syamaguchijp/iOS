import UIKit

class User: NSObject {

    static let shared = User()
    
    var userName: String?
    var password: String?

    // シングルトン
    private override init() {
        super.init()
    }
    
}

let user1 = User.shared
let user2 = User.shared
