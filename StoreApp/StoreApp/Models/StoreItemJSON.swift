//
//  StoreItemJSON.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct StoreItemJSON: Decodable {
    let statusCode: Int
    let body: [StoreItem]
}
