//
//  YmCoreDataManager.swift
//  SampleCoreData
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit
import CoreData

class YmCoreDataManager: NSObject {

    let persistentStoreCoordinator: NSPersistentStoreCoordinator?
    let context: NSManagedObjectContext?
    
    /// @param resource .xcdatamodeldファイルの名称文字列が入ってくることを想定
    init?(resource: String) {
        
        // 管理対象オブジェクト作成
        guard let modelURL = Bundle.main.url(forResource: resource, withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL) else {
                return nil
        }
        // SQLiteにつなぐ永続ストアコーディネータの作成
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
        
        // ストアURL
        guard let applicationDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }
        let storeURL = applicationDocumentsDirectory.appendingPathComponent(resource + ".sqlite")
        
        // 簡単マイグレーション用のオプション追加
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        
        // 永続ストアの追加
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        } catch {
            return nil
        }
        
        // 管理対象オブジェクトコンテキストを作成
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.persistentStoreCoordinator = coordinator
        self.context = managedObjectContext
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
    }
    
}
