//
//  MenuItem.swift
//  StoreApp
//
//  Created by Summer on 25/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import Foundation

struct MenuItem : Codable{
    var category : String
    var title : String
    var items : [StoreItem]
    subscript(index: Int) -> StoreItem? {
        get {
            return items.count > index ? self.items[index] : nil
        }
        set(newValue) {
            self.items[index] = newValue!
        }
    }
}
