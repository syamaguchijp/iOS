import UIKit

// ヒープの作成とヒープソート
// Heap = 完全二分木（親の値 >= 子の値）

class HeapSort {

    // 配列をヒープ化する
    func makeHeap(array: inout Array<Int>, heapSize: Int, root: Int) {

        var largest = root
        let left = 2 * root + 1
        let right = 2 * root + 2
 
        // 左の子が根より大きい時
        if left < heapSize && array[left] > array[largest] {
            largest = left
        }
 
        // 右の子がlargetsより大きい時
        if right < heapSize && array[right] > array[largest] {
            largest = right
        }

        if largest != root {
            let temp = array[root]
            array[root] = array[largest]
            array[largest] = temp
 
            // 再帰的に実行
            makeHeap(array: &array, heapSize: heapSize, root: largest)
        }
    }

    // 配列に対してヒープソートを実行する
    func heapSort(array: inout Array<Int>) {
        
        for i in (0..<array.count/2).reversed() {
            makeHeap(array: &array, heapSize: array.count, root: i)
        }

        for i in (0..<array.count).reversed() {
            let temp = array[0]
            array[0] = array[i]
            array[i] = temp
 
            makeHeap(array: &array, heapSize: i, root: 0)
        }
    }
}

var array = [20, 1, 11, 41, 200, 69, 81, 30]
HeapSort().heapSort(array: &array) // 参照渡し

for i in array {
    print(i)
}
