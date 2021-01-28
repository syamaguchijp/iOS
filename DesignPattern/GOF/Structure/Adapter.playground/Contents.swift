import UIKit

class Adaptee {
    func doAdaptee() {
        print("Adaptee > func methodA")
    }
}

protocol Target {
    func doTarget()
}

// 既存のAdapteeクラスに手を加えずに、Targetプロトコルを適合させる。
// 新しい版（Adaptee）に古い版（Target）のメソッドを実装するような場合。
class Adapter: Adaptee, Target {
    
    func doTarget() {
        super.doAdaptee()
    }
}

Adapter().doTarget()
