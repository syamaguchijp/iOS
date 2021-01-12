//
//  BinarySearch.swift
//  SampleAlgorithm
//
//  Copyright © 2020年 Yamaguchi. All rights reserved.
//

import UIKit

class BinarySearch: NSObject {
    
    /// @param searchNumber 探索する数値
    /// @param array 昇順にソートされていることが前提
    /// @return 配列に存在しない場合はnilを返却する。存在する場合は配列の該当indexを返却する。
    static func search(searchNumber: Int, array:[Int]) -> Int? {
        
        var minIndex = 0
        var maxIndex =  array.count - 1
        
        while minIndex <= maxIndex {
            let midIndex = (minIndex + maxIndex) / 2
            if array[midIndex] == searchNumber {
                return midIndex
            } else if array[midIndex] > searchNumber {
                maxIndex = midIndex - 1
            } else {
                minIndex = midIndex + 1
            }
        }
        
        return nil
    }

}
