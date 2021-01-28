import UIKit

// 複数のオブジェクト(Peer)の間でMediator（仲介者）を通してやりとりするため、クラス間が疎結合となる

class Mediator {
    private var peers: [Peer] = []
    func addPeer(peer: Peer) {
        peers.append(peer)
    }
    func send(message: String) {
        for peer in peers {
            peer.receive(message: message)
        }
    }
}

protocol Peer {
    func receive(message: String)
}

class Dog: Peer {
    func receive(message: String) {
        print ("受け取ったメッセージは、\(message)だワン")
    }
}

class Cat: Peer {
    func receive(message: String) {
        print ("受け取ったメッセージは、\(message)だニャン")
    }
}

let mediator = Mediator()
let dog = Dog()
let cat = Dog()
let dog2 = Dog()
let cat2 = Dog()
mediator.addPeer(peer: dog)
mediator.addPeer(peer: cat)
mediator.addPeer(peer: dog2)
mediator.addPeer(peer: cat2)
mediator.send(message: "hogehoge")
