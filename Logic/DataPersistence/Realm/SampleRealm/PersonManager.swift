//
//  PersonManager.swift
//  SampleRealm
//
//  Created by Yamaguchi on 2021/01/20.
//

import UIKit
import RealmSwift

class PersonManager: NSObject {

    // MARK: write
    
    func write(person: Person) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(person)
        }
    }

    // MARK: delete
    
    func delete(person: Person) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(person)
        }
    }
    
    func deleteAll() {
        
        let realm = try! Realm()
        let results: Results<Person> = fetchAll()
        try! realm.write {
            realm.delete(results)
        }
    }
    
    // MARK: update
    
    func updateName(person: Person, name: String) {
        
        let realm = try! Realm()
        try! realm.write {
            person.name = name
        }
    }
    
    // MARK: fetch
    
    func fetchAll() -> Results<Person> {
        
        let realm = try! Realm()
        
        return realm.objects(Person.self)
    }
    
    func fetchAll() -> [Person] {
        
        let realm = try! Realm()
        
        let results = realm.objects(Person.self)
        
        var persons = [Person]()
        for person in results {
            persons.append(person)
        }
        return persons
    }
    
    /// @param filter フィルタ文字列  e.g. "age < 20"
    func fetch(filter: String) -> Results<Person> {
        
        let realm = try! Realm()
        
        return realm.objects(Person.self).filter(filter)
    }
    
    /// @param filter フィルタ文字列
    func fetch(filter: String) -> [Person] {
        
        let realm = try! Realm()
        
        let results = realm.objects(Person.self).filter(filter)
        
        var persons = [Person]()
        for person in results {
            persons.append(person)
        }
        return persons
    }

}
