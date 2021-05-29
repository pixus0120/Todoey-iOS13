//
//  Category.swift
//  Todoey
//
//  Created by locussigilli on 5/27/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()    //array
   // var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
