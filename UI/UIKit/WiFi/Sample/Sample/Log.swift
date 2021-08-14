//
//  Log.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/14.
//

import UIKit

class Log: NSObject {

    class func log(_ msg: String) {
        
        print("\(msg)")
        
        return
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dumpStr = String(format:"%@  %@\n", formatter.string(from: Date()), msg)
        Log.write(dumpStr, fileName: "log.txt")
    }
    
    fileprivate class func makeDirectory() {
        
        let fileManager = FileManager.default
        let documentsPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let dirPathStr = documentsPath.path
        
        if !fileManager.fileExists(atPath: dirPathStr) {
            do {
                try fileManager.createDirectory(atPath: dirPathStr, withIntermediateDirectories: true, attributes: nil)
                
            } catch let error as NSError {
                print("Unable to create directory \(error.debugDescription)")
                return
            }
        }
    }
    
    fileprivate class func write(_ msg: String, fileName: String) {
        
        Log.makeDirectory()
        
        guard let fPath = Log.makeFilePath(fileName) else {
            return
        }
        
        guard let fileHandle = FileHandle(forWritingAtPath: fPath) else {
            return
        }
        
        let data = msg.data(using: String.Encoding.utf8)!
        fileHandle.seekToEndOfFile()
        fileHandle.write(data)
        fileHandle.closeFile()
    }
    
    fileprivate class func makeFilePath(_ fileName: String) -> String? {
        
        let fileManager = FileManager.default
        let documentsPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        
        let dPath = documentsPath.path
        let filePath = dPath + "/" + fileName
        
        if !fileManager.fileExists(atPath: filePath) {
            fileManager.createFile(atPath: filePath, contents: Data(), attributes: nil)
        }
        
        return filePath
    }
}
