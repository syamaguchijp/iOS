import UIKit

// 機能のクラス階層と実装のクラス階層を分離し、依存性を注入して結びつける
// クラスの爆発を防ぐ

// 機能
class Drawer {
    var impl: DrawImpl
    init(impl: DrawImpl) {
        self.impl = impl
    }
    func draw() {
        impl.print()
    }
}
class SubDrawer: Drawer {
    func multiDraw() {
        for _ in 1...5 {
            super.draw()
        }
    }
}

// 実装
protocol DrawImpl {
    func print()
}
class CircleDrawImpl: DrawImpl {
    func print() {
        Swift.print("print Circle")
    }
}
class RectangleDrawImpl: DrawImpl {
    func print() {
        Swift.print("print Rectangle")
    }
}


let drawer = Drawer(impl: CircleDrawImpl())
drawer.draw()

let subDrawer = SubDrawer(impl: RectangleDrawImpl())
subDrawer.multiDraw()
