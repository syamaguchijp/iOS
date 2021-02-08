//
//  ViewController.swift
//  SampleRealm
//
//  Created by Yamaguchi on 2021/01/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = PersonManager.init()
        
        manager.deleteAll()
        
        let person = Person()
        person.id = 1
        person.age = 20
        person.name = "Yamaguchi"
        manager.write(person:person)
        
        let persons: [Person] = manager.fetchAll()
        print(persons)
        
        let persons2: [Person] = manager.fetch(filter: "age < 20")
        print(persons2)
        
        let persons3: [Person] = manager.fetch(filter: "age >= 20")
        print(persons3)
        
        manager.updateName(person: persons3[0], name: "Yamada")
        
        let persons4: [Person] = manager.fetchAll()
        print(persons4)
        
    }


}

