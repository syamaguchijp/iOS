import UIKit

// 最短経路アルゴリズム　ダイクストラ法
class Dijkstra {

     /// 出発地点から到着地点の距離を求める
     /// @param mapArray 地点マップ用多次元配列（各ノードの距離関係）「mapArray[fromNode][toNode] = 距離」
     /// @param nodeNum 全ノード数
     /// @param startNode 出発地点ノード
     /// @param endNode 到着地点ノード
     func execute(mapArray: Array<Array<Int?>>, nodeNum: Int, startNode: Int, endNode: Int) {

        // 初期化
        var resultArray = Array<Result>()
        for _ in 0..<nodeNum {
            resultArray.append(Result())
        }
        resultArray[startNode].distance = 0 // 出発地点までの距離は0

        while true {
            // 未確定の中で最も近いノードを求める
            let nearestIndex = findNearestNode(resultArray: resultArray)
            if nearestIndex < 0 {
                break // 全ノードが確定した場合
            }
            if resultArray[nearestIndex].distance == Int.max {
                break // 非連結グラフのためbreak
            }
            resultArray[nearestIndex].isFixed = true // 当該ノードまでの最短距離が確定となる
            // 「mapArray[fromNode][toNode] = 距離」であるため、配列を走査して隣のNodeとの距離を調べる
            for i in 0..<nodeNum {
                if let temp = mapArray[nearestIndex][i] {
                    if !resultArray[i].isFixed { // 距離がまだ未確定であればその距離を求めて記録する
                        let minDistance = resultArray[nearestIndex].distance + temp
                        // 今までの距離よりも小さいものであれば記録
                        if minDistance < resultArray[i].distance {
                            resultArray[i].distance = minDistance
                        }
                    }
                }
            }
        }
        // 結果を出力する
        if resultArray[endNode].distance == Int.max {
            print("FAIL")
        } else {
            print("Distance is \(resultArray[endNode].distance)");
        }
    }

    // まだ距離が確定していないNodeの中で、最も近いものを探す
    private func findNearestNode(resultArray: Array<Result>) -> Int {
        
        var ans = 0
        for _ in 0..<resultArray.count {
            if !resultArray[ans].isFixed {
                // 未確定のNode
                break
            }
            ans += 1
        }
        if ans == resultArray.count {
            // 未確定のNodeが存在しないため終了
            return -1
        }
        // 距離が短いものを探す
        for i in ans+1..<resultArray.count {
            if !resultArray[i].isFixed && resultArray[i].distance < resultArray[ans].distance {
                ans = i
            }
        }
        return ans
    }
}

class Result {
    var distance = Int.max
    var isFixed = false // 最短距離が確定したかどうか
}

let nodeNum = 7 // 全ノード数
let startNode = 0 // 出発地点
let endNode = 6 // 到着地点

// 地点マップ用多次元配列「mapArray[fromNode][toNode] = 距離」
var mapArray = Array<Array<Int?>>(repeating: Array<Int?>(repeating: nil, count: nodeNum), count: nodeNum)
mapArray[0][1] = 72
mapArray[0][3] = 24
mapArray[0][2] = 36
mapArray[1][3] = 60
mapArray[1][4] = 145
mapArray[2][3] = 95
mapArray[2][5] = 49
mapArray[3][6] = 81
mapArray[4][6] = 50
mapArray[5][6] = 70

Dijkstra().execute(mapArray: mapArray, nodeNum: nodeNum, startNode: startNode, endNode: endNode)
