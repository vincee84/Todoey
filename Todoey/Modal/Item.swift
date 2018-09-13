//
//  Item.swift
//  Todoey
//
//  Created by Vince Ng on 13/9/18.
//  Copyright © 2018 kindebean. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date?
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
