//
//  Category.swift
//  Todoey
//
//  Created by Vince Ng on 13/9/18.
//  Copyright © 2018 kindebean. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name = ""
    let items = List<Item>()
}
