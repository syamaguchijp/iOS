//
//  PersonDataManager.swift
//  SampleCoreData
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit
import CoreData

class MemberDataManager: NSObject {
    
    func writeData() {

        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let coreDataManager = YmCoreDataManager.init(resource: "Model")!
        guard let context = coreDataManager.context else {
            return
        }

        let entity = NSEntityDescription.entity(forEntityName: "Member", in: context)
        let member = NSManagedObject(entity: entity!, insertInto: context) as! Member
        member.name = "山口"
        member.gender = false
        member.age = 20
        member.birthday = Date()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func fetchData() -> Array<Member>? {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let coreDataManager = YmCoreDataManager.init(resource: "Model")!
        guard let context = coreDataManager.context else {
            return nil
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Member", in: context)
        //let fetchRequest = NSFetchRequest<Member>(entityName: "Member")
        let fetchRequest = NSFetchRequest<Member>.init()
        fetchRequest.entity = entity
        
        // fetchRequest に NSPredicate を指定する場合は、ここに。
        
        let fetchData = try! context.fetch(fetchRequest)
        
        // Memberオブジェクトとして生成
        var memberList: Array<Member> = []
        for i in 0..<fetchData.count{
            let entity = NSEntityDescription.entity(forEntityName: "Member", in: context)
            let member = NSManagedObject(entity: entity!, insertInto: context) as! Member
            member.name = fetchData[i].name
            member.gender = fetchData[i].gender
            member.age = fetchData[i].age
            member.birthday = fetchData[i].birthday
            memberList.append(member)
        }
        
        print("##### memberList = \(memberList)")
        
        return memberList
    }
    
    func updateData() {
       
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let coreDataManager = YmCoreDataManager.init(resource: "Model")!
        guard let context = coreDataManager.context else {
            return
        }
        
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        //let predicate = NSPredicate(format:"%K = %@", "name", "山口")
        //fetchRequest.predicate = predicate
        let fetchData = try! context.fetch(fetchRequest)
        if (fetchData.isEmpty) {
            return
        }
  
        for i in 0..<fetchData.count{
            fetchData[i].name = "山田"
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteAllData() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")

        let coreDataManager = YmCoreDataManager.init(resource: "Model")!
        guard let context = coreDataManager.context else {
            return
        }
        
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        let fetchData = try! context.fetch(fetchRequest)
        if (fetchData.isEmpty) {
            return
        }
  
        for object in fetchData {
            print("$$$ delete \(object)")
            context.delete(object)
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
