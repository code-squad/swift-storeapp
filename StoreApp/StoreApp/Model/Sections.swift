//
//  Sections.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 14..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation
import Reachability

class Sections {
    
    private var sections = [Section]()
    var count : Int {
        return sections.count
    }
    
    subscript(index : Int) -> Section {
        return sections[index]
    }
    
    init() {
        sections = [Section(.main), Section(.side), Section(.soup)]
    }
    
    func getItem(_ indexPath: IndexPath) -> Item {
        return sections[indexPath.section].storeItems[indexPath.row]
    }
    
    func generateIndexPaths(_ sectionHeader: Section.Header) -> [IndexPath] {
        guard let sectionIndex = sections.index(where: {$0.headerType == sectionHeader.type}) else { return [] }
        return Array(0..<sections[sectionIndex].storeItems.count).map({IndexPath(row: $0, section: sectionIndex)})
    }
    
    func setStoreItemsFromJSON() {
        sections.forEach({$0.setStoreItems($0.headerType)})
    }
    
}
