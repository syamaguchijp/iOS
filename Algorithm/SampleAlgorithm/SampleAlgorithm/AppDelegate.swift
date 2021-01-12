//
//  AppDelegate.swift
//  SampleAlgorithm
//
//  Copyright © 2020年 Yamaguchi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let answer1 = BinarySearch.search(searchNumber: 99, array: ([Int])(0..<100))
        if let answer1 = answer1 {
            print(answer1)
        }
        
        let answer2 = RoundRobin.makeRoundRobin(array: [0, 1, 2, 3])
        print(answer2)
        
        var array = [5, 4, 3, 2, 1, 0]
        let answer3 = QuickSort.sort(array: &array)
        print(answer3)
        
        return true
    }

}

