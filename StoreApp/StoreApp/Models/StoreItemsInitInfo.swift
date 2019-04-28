//
//  SectionInitInfo.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct StoreItemsInitInfo {
    let fileName: String
    let sectionInfo: SectionInfo
    
    init(fileName: String, title: String, description: String) {
        self.fileName = fileName
        self.sectionInfo = SectionInfo(title: title, description: description)
    }
}
