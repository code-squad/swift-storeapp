//
//  Sections.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 14..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

class Sections {
    
    private var sections = [Section]()
    var count : Int {
        return sections.count
    }
    
    subscript(index : Int) -> Section {
        return sections[index]
    }
    
    subscript(indexPath : IndexPath) -> Section {
        return sections[indexPath.section]
    }
    
    init() {
        sections = [Section(.main), Section(.side), Section(.soup)]
    }
    
}
