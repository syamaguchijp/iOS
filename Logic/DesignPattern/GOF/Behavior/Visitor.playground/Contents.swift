import UIKit

// 異種のオブジェクトからなるコレクションに適用される

protocol Shape {
    func accept(visitor: Visitor)
}

class Circle: Shape {
    let radius: Float
    init(radius: Float) {
        self.radius = radius
    }
    func accept(visitor: Visitor) {
        visitor.visit(shape: self)
    }
}

class Rectangle: Shape {
    let length: Float
    init(length: Float) {
        self.length = length
    }
    func accept(visitor: Visitor) {
        visitor.visit(shape: self)
    }
}

class ShapeCollection {
    let shapes: [Shape]
    init() {
        shapes = [Circle(radius: 5), Circle(radius: 10), Rectangle(length: 20)]
    }
    func accept(visitor: Visitor) {
        for shape in shapes {
            shape.accept(visitor: visitor)
        }
    }
}

// 新しい処理を追加したいときは新しいVisitorを作ればよい

protocol Visitor {
    func visit(shape: Circle)
    func visit(shape: Rectangle)
}

class AreaVisitor: Visitor {
    var total: Float = 0
    func visit(shape: Circle) {
        total += (3.14 * powf(shape.radius, 2))
    }
    func visit(shape: Rectangle) {
        total += powf(shape.length, 2)
    }
}

class EdgeVisitor: Visitor {
    var total: Float = 0
    func visit(shape: Circle) {
        total += 1
    }
    func visit(shape: Rectangle) {
        total += 4
    }
}


let shapes = ShapeCollection()
let areaVisitor = AreaVisitor()
shapes.accept(visitor: areaVisitor)
print("\(areaVisitor.total)")
