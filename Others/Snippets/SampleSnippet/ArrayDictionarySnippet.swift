//
//  ArrayDictionarySnippet.swift
//  SampleSnippet
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

class ArrayDictionarySnippet: NSObject {

    var myArray: [Int]
    var myDictionary: [String: Int]
    var mySet: Set = ["a", "b"]
    
    override init() {
    
        // MARK: Array
        
        myArray = []
        myArray = [2, 3, 4, 5, 6, 7]
        myArray.insert(1, at: 0) // 要素の追加（0の位置に値1を追加）
        myArray.append(8) // 末尾に追加
        myArray.append(9)
        myArray.remove(at :myArray.count - 1) //末尾を削除
        myArray.removeLast() // 末尾を削除
        myArray = myArray + [9, 8, 10] // 配列の結合
        myArray.sort() // 配列を昇順にソート
        //myArray.removeAll() // 要素をすべて削除
        print("count = \(myArray.count)")
        print("isEmpty = \(myArray.isEmpty)")
        print("contains(0) = \(myArray.contains(0))")
        print("myArray =  \(myArray)")
        
        for element in myArray {
            print("for element = \(element)")
        }
        
        for i in 0...2 {
            print("myArray[i] = \(myArray[i])")
        }
        
        for element in myArray where element < 4{
            print("where element = \(element)")
        }
        
        label: for element in 0...5 {
            print("label for element = \(element)")
            for nestedElement in 10...15 {
                print("nestedElement = \(nestedElement)")
                break label
            }
        }
        
        
        // MARK: Dictionary
        
        myDictionary = [:]
        myDictionary = ["monday": 1, "tuesday": 1, "wednesday": 2]
        myDictionary["monday"] = 0 // 値の更新
        myDictionary["thursday"] = 3 // 値の追加
        myDictionary["thursday"] = nil // 値の削除
        print("myDictionary['thursday'] \(String(describing: myDictionary["thursday"]))")
        print("count = \(myDictionary.count)")
        print("isEmpty = \(myDictionary.isEmpty)")
        print("keys.contains(monday) = \(myDictionary.keys.contains("monday"))")
        //print("values.contains(1) = \(myDictionary.values.contains(where: 1))")
        //print("values.sorted = \(myDictionary.values.sorted())") // キーまたは値を並び替えた結果を配列で返す
        //myDictionary.merge(["friday": 4])
        
        for key in myDictionary.keys {
            print("for key = \(key)")
        }
        
        for value in myDictionary.values {
            print("for value = \(value)")
        }
        
        for (key, value) in myDictionary {
            print("key = \(key)")
            print("value = \(value)")
        }
        
        myDictionary.forEach({(key: String, value: Any) in
            print("forEach key=\(key)")
            print("forEach value=\(value)")
        })
        
        
        // MARK: Set
        
        // セット型は重複を許さないが順番は保証されない
        mySet.insert("c")
        mySet.insert("d")
        mySet.remove("d")
        print("mySet = \(mySet)")
        
        for element in mySet {
            print("mySet element = \(element)")
        }
        
        
        // MARK: Tupple
        
        // データ型なし
        let a = ("a", 100)
        print("a.0=\(a.0)") // "a"
        print("a.1=\(a.1)") // 100
        
        // データ型なし かつ 名前付き
        let b = (name: "taro", age: 10)
        print("b.name=\(b.name)") // "taro"
        print("b.age=\(b.age)") // 10
        
        // データ型あり
        let c:(String, Int) = ("a", 100)
        print("c.0=\(c.0)") // "a"
        print("c.1=\(c.1)") // 100
        
        // データ型あり かつ 名前付き
        let d:(name: String, age: Int)
        d.name = "taro"
        d.age = 10
        print("d.name=\(d.name)")
        print("d.age=\(d.age)")
    }
    
}
