//
//  QuickSort.swift
//  SampleAlgorithm
//
//  Copyright © 2020年 Yamaguchi. All rights reserved.
//

import UIKit

class QuickSort: NSObject {
    
    static func sort(array: inout [Int]) -> [Int] {
        
        QuickSort.quickSort(array: &array, leftIndex: 0, rightIndex: array.count - 1)
        return array
    }

    static private func quickSort(array: inout [Int], leftIndex: Int, rightIndex: Int) {
        
        var leftCursor = leftIndex
        var rightCursor = rightIndex
        let middleValue = array[(leftCursor + rightCursor) / 2]
        
        repeat {
            while array[leftCursor] < middleValue {
                leftCursor += 1
            }
            while array[rightCursor] > middleValue {
                rightCursor -= 1
            }
            if leftCursor <= rightCursor {
                QuickSort.swap(array: &array, left: leftCursor, right: rightCursor)
                leftCursor += 1
                rightCursor -= 1
            }
        } while leftCursor <= rightCursor
        
        if leftIndex < rightCursor {
            QuickSort.quickSort(array: &array, leftIndex: leftIndex, rightIndex: rightCursor)
        }
        if leftCursor < rightIndex {
            QuickSort.quickSort(array: &array, leftIndex: leftCursor, rightIndex: rightIndex)
        }
    }
    
    static private func swap(array: inout [Int], left: Int, right: Int) {
        
        let tempValue = array[left]
        array[left] = array[right]
        array[right] = tempValue
    }
    
}

class QuickSortObject: NSObject {
    
    static func sort(array: inout [Hoge]) -> [Hoge] {
        
        QuickSortObject.quickSort(array: &array, leftIndex: 0, rightIndex: array.count - 1)
        
        return array
    }
    
    static private func quickSort(array: inout [Hoge], leftIndex: Int, rightIndex: Int) {
        
        var leftCursor = leftIndex
        var rightCursor = rightIndex
        let middleOjbect = array[(leftCursor + rightCursor) / 2]
        
        repeat {
            while array[leftCursor].number < middleOjbect.number {
                leftCursor += 1
            }
            while array[rightCursor].number > middleOjbect.number {
                rightCursor -= 1
            }
            if leftCursor <= rightCursor {
                QuickSortObject.swap(array: &array, left: leftCursor, right: rightCursor)
                leftCursor += 1
                rightCursor -= 1
            }
        } while leftCursor <= rightCursor
        
        if leftIndex < rightCursor {
            QuickSortObject.quickSort(array: &array, leftIndex: leftIndex, rightIndex: rightCursor)
        }
        if leftCursor < rightIndex {
            QuickSortObject.quickSort(array: &array, leftIndex: leftCursor, rightIndex: rightIndex)
        }
    }
    
    static private func swap(array: inout [Hoge], left: Int, right: Int) {
        
        let tempValue = array[left]
        array[left] = array[right]
        array[right] = tempValue
    }
    
}

class Hoge: NSObject {
    var number: Int = 0
}
