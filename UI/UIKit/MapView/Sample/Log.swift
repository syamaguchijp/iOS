//
//  Log.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/20.
//

import UIKit
import CoreLocation

class Log: NSObject {

    class func log(_ msg: String) {
        
        print("\(msg)")
        /*
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dumpStr = String(format:"%@  %@\n", formatter.string(from: Date()), msg)
        Log.write(dumpStr, fileName: "log.txt")
        */
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
    
    fileprivate class func deleteFile(_ fileName: String) {
        
        let fileManager = FileManager.default
        guard let fPath = Log.makeFilePath(fileName) else {
            return
        }
        if !fileManager.fileExists(atPath: fPath) {
            return
        }
        do {
            try fileManager.removeItem(atPath: fPath)
        } catch {
            print("Removing file failed!")
        }
    }
    
    // MARK: Location Log
    
    static let locationFileName = "location.txt"
    
    class func logLocation(_ location: CLLocation) {
        
        let dumpStr = "\(location.coordinate.latitude),\(location.coordinate.longitude)\n"
        Log.write(dumpStr, fileName: locationFileName)
    }
    
    class func readLocation() -> Array<CLLocationCoordinate2D> {
        
        var ans = Array<CLLocationCoordinate2D>()
        
        guard let fPath = Log.makeFilePath(locationFileName) else {
            return ans
        }
        guard let fileHandle = FileHandle(forReadingAtPath: fPath) else {
            return ans
        }
        
        let fileData = fileHandle.readDataToEndOfFile()
        let contentString = String(data: fileData, encoding: .utf8)!
        fileHandle.closeFile()
        
        let lineAry = contentString.components(separatedBy: "\n")
        for line in lineAry {
            if line.count == 0 {
                continue
            }
            let tempAry = line.components(separatedBy: ",")
            if let tempLat = Double(tempAry[0]), let tempLon = Double(tempAry[1]) {
                let tempLocation = CLLocationCoordinate2DMake(tempLat, tempLon)
                ans.append(tempLocation)
            }
        }
        return ans
    }
    
    class func deleteAllLocation() {
        
        deleteFile(locationFileName)
    }
}
