import UIKit

protocol DrawCommand {
    func draw()
}

class DrawRect: DrawCommand {
    func draw() {
        print("四角形を書く")
    }
}

class DrawRound: DrawCommand {
    func draw() {
        print("円を書く")
    }
}

// 命令を呼び出す方法を集約。
// 出した命令の履歴を把握することなどに役立つ
class DrawManager {
    let drawRect = DrawRect()
    let drawRound = DrawRound()
    
    func draw1() {
        drawRect.draw()
    }
    func draw2() {
        drawRound.draw()
    }
}
