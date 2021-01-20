//
//  Person.swift
//  SampleRealm
//
//  Created by Yamaguchi on 2021/01/20.
//

import Foundation
import RealmSwift

class Person: Object {

    @objc dynamic var id : Int = 0
    @objc dynamic var name = ""
    @objc dynamic var age: Int = 0
}
