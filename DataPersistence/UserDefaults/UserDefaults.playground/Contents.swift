import UIKit

class UserDefaultsManager: NSObject {
    
    static let shared = UserDefaultsManager()

    private let ud = UserDefaults.standard
    private let KeyForUserId = "KeyForUserID"
    private let KeyForUserName = "KeyForUserName"
    private let KeyForIsSpecial = "KeyForIsSpecial"
    
    private override init() {
        super.init()
    }

    var userId: Int64? {
        
        get {
            return Int64(ud.integer(forKey: KeyForUserId))
        }
        
        set(userId) {
            ud.set(userId, forKey: KeyForUserId)
        }
    }

    var userName: String? {
        
        get {
            return ud.string(forKey: KeyForUserName)
        }
        
        set(userName) {
            ud.set(userName, forKey: KeyForUserName)
        }
    }
    
    var isSpecial: Bool {
        
        get {
            return ud.bool(forKey: KeyForIsSpecial)
        }
        
        set(isSpecial) {
            ud.set(isSpecial, forKey: KeyForIsSpecial)
        }
    }
}

let um = UserDefaultsManager.shared
um.userName = "John"
print("\(um.userName)")
