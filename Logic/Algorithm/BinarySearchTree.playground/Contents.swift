import UIKit

// 二分探索木
class BinaryTree<K: Comparable, V> {
    
    var root: Node<K, V>?

    // ノードを挿入する
    func add(key: K, value: V) {

        if let root = root {
            addNode(node: root, key: key, value: value)
        } else {
            root = Node.init(key: key, value: value)
        }
    }

    // nodeを根とする部分木に、keyとvalueで構成されるノードを挿入する
    private func addNode(node: Node<K, V>, key: K, value: V) {

        let compResult = compare(key1: key, key2: node.key)
        if compResult == 0 {
            // keyは既に存在するためためreturn
            return

        } else if compResult < 0 {
            // 挿入するkeyの方がnode.keyより小さい場合、左に進む
            if let left = node.left {
                // 既に存在する場合は、左下に進める
                addNode(node: left, key: key, value: value)
            } else {
                node.left = Node.init(key: key, value: value)
            }
            
        } else {
            // 挿入keyの方がnode.keyより大きい場合、右に進める
            if let right = node.right {
                // 既に存在する場合は、右下に進める
                addNode(node: right, key: key, value: value)
            } else {
                node.right = Node.init(key: key, value: value)
            }
        }
    }

    // ノードを削除する
    func remove(key: K) -> Bool {

        var pointerNode = root
        var parentNode: Node<K, V>?
        var isLeftChild = true // pointerNodeはparentNodeの左子ノードかどうか

        // まず削除するキーを探索する
        while true {
            if pointerNode == nil {
                return false // これ以上進めない時はキーは存在しない
            }

            let result = compare(key1: key, key2: pointerNode!.key)
            if result == 0 {
                break // 探索に成功したためbreakする
            } else {
                parentNode = pointerNode
                if result < 0 {
                    isLeftChild = true
                    pointerNode = pointerNode!.left!
                } else {
                    isLeftChild = false
                    pointerNode = pointerNode!.right!
                }
            }
        }

        guard let pn = pointerNode else {
            return false
        }

        // 左の子ノードをもたないノードの削除
        if pn.left == nil {
            if pn === root {
                root = pn.right
            } else if isLeftChild {
                parentNode?.left = pn.right
            } else {
                parentNode?.right = pn.right
            }

        // 左に子ノードがあるが右に子ノードがないノードの削除
        } else if pn.right == nil {
            if pn === root {
                root = pn.left
            } else if isLeftChild {
                parentNode?.left = pn.left
            } else {
                parentNode?.right = pn.left
            }

        // 左右の子ノードを持つノードの削除
        } else {
            // 左部分木の最大値を持ってきて据え置く
            parentNode = pn
            var leftNode = pn.left!
            isLeftChild = true
            while leftNode.right != nil {
                parentNode = leftNode
                leftNode = leftNode.right!
                isLeftChild = false
            }
            pn.key = leftNode.key
            pn.value = leftNode.value
            if isLeftChild {
                parentNode?.left = leftNode.left
            } else {
                parentNode?.right = leftNode.right
            }
        }
        return true
    }

    func search(key: K) -> V? {

        var rootNode = root
        while true {
            if rootNode == nil {
                return nil
            }
            let compResult = compare(key1: key, key2: rootNode!.key)
            if compResult == 0 {
                // 探索に成功したためreturn
                return rootNode!.value
            } else if compResult < 0 {
                // keyの方がrootNode.keyより小さい場合、左部分木へと探索を進める
                rootNode = rootNode!.left!
            } else {
                // keyの方がrootNode.keyより大きい場合、右部分木へと探索を進める
                rootNode = rootNode!.right!
            }
        }
    }

    // 第1引数が第2引数より小さい場合は負の整数、両方が等しい場合は0、第1引数が第2引数より大きい場合は正の整数を返す
    private func compare(key1: K, key2: K) -> Int {
        
        if key1 > key2 {
            return 1
        } else if key1 < key2 {
            return -1
        }
        return 0
    }

    // すべてノードを昇順にダンプしていく
    func dumpAll() {

        dumpNode(node: root)
    }

    private func dumpNode(node : Node<K, V>?) {

        guard let node = node else {
            return
        }
        dumpNode(node: node.left)
        print("node key=\(node.key) value=\(node.value)")
        dumpNode(node: node.right)
    }
}

class Node<K, V> {
    var key: K
    var value: V
    var left: Node<K, V>?
    var right: Node<K, V>?
    
    init(key: K, value: V) {
        self.key = key
        self.value = value
    }
}

let binaryTree = BinaryTree<Int, String>()
binaryTree.root = Node.init(key: 10, value: "AAA")
binaryTree.add(key: 11, value: "BBB")
binaryTree.add(key: 9, value: "CCC")
binaryTree.add(key: 13, value: "DDD")
binaryTree.add(key: 7, value: "EEE")
binaryTree.add(key: 8, value: "FFF")
binaryTree.add(key: 12, value: "GGG")
binaryTree.remove(key: 7)
binaryTree.dumpAll()
print("\(binaryTree.search(key: 8))")


let binaryTree2 = BinaryTree<String, String>()
binaryTree2.root = Node.init(key: "H", value: "hhh")
binaryTree2.add(key: "I", value: "iii")
binaryTree2.add(key: "G", value: "ggg")
binaryTree2.add(key: "K", value: "kkk")
binaryTree2.add(key: "E", value: "eee")
binaryTree2.add(key: "F", value: "fff")
binaryTree2.add(key: "J", value: "jjj")
binaryTree2.dumpAll()
