//
//  GCDSnippet.swift
//  SampleSnippet
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

class GCDSnippet: NSObject {

    let queue = DispatchQueue(label: "jp.someQueue")
    
    // 排他制御するためのセマフォ（URLSessionがsynchronousではないため必要）
    // セマフォカウンタを1で初期化する
    let semaphore = DispatchSemaphore(value: 1)
    
    /// URLSessionなどの非同期処理が入らない場合は、これで排他制御できる
    func execute() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) 1")
        
        // サブスレッドで実行
        queue.async {
            
            print("\(NSStringFromClass(type(of: self))) \(#function) 2")
            
            Thread.sleep(forTimeInterval: 3.0)
            
            print("\(NSStringFromClass(type(of: self))) \(#function) 3")
            
            // メインスレッドで実行
            DispatchQueue.main.async {
                
                print("\(NSStringFromClass(type(of: self))) \(#function) 4")
            }
        }
    }
    
    /// URLSessionなどの非同期処理が入る場合は、セマフォの上げ下げを行うことにより排他制御できる
    func executeSemaphore() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) 1")

        // サブスレッドで実行
        queue.async {
           
            print("\(NSStringFromClass(type(of: self))) \(#function) 2")
            
            // セマフォのカウンタが1以上になるまで待つ。これにより dispatch_semaphore_signal がコールされるまで、排他制御が可能。
            _ = self.semaphore.wait(timeout: .distantFuture)
            
            print("\(NSStringFromClass(type(of: self))) \(#function) 3")
            
            Thread.sleep(forTimeInterval: 3.0)
            
            // メインスレッドで実行
            DispatchQueue.main.async {
                
                print("\(NSStringFromClass(type(of: self))) \(#function) 4")

                // 排他制御用セマフォのカウンタを戻す
                self.semaphore.signal()
            }
        }
    }
}
