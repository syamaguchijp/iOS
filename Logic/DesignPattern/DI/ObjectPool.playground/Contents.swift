import UIKit

class ObjectPool<T> {
    
    // 複数のスレッドから同時に出し入れされるときのためのデータ保護
    private let queue = DispatchQueue(label: "MyQueue")
    private let semaphore: DispatchSemaphore
    
    var objectArray = [T]()
    
    init(_ objects: [T]) {
        objectArray.reserveCapacity(objectArray.count)
        for obj in objects {
            objectArray.append(obj)
        }
        semaphore = DispatchSemaphore.init(value: objects.count)
    }
    
    func getFromPool() -> T? {
        var result: T?
        if (semaphore.wait(timeout: .distantFuture) == .success) {
            queue.sync(execute: {() in
                result = self.objectArray.remove(at: 0)
            })
        }
        return result
    }
    
    func returnToPool(object: T) {
        queue.async {() in
            self.objectArray.append(object)
            self.semaphore.signal()
        }
    }
}


class User {
    let name: String
    init(name: String) {
        self.name = name
    }
}


var users = [User]()
users.append(User.init(name: "yamada"))
users.append(User.init(name: "takeda"))
users.append(User.init(name: "hara"))
users.append(User.init(name: "kawakami"))
users.append(User.init(name: "ueda"))
let objectPool = ObjectPool(users)

let currentUser = objectPool.getFromPool()!
print("1 \(currentUser.name)")
for obj in objectPool.objectArray {
    print("2 \(obj.name)")
}

objectPool.returnToPool(object: currentUser)
for obj in objectPool.objectArray {
    print("3 \(obj.name)")
}
