//
//  ItemFromHTTP.swift
//  StoreApp
//
//  Created by 윤동민 on 18/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

class ItemFromHTTP: Decodable {
    var statusCode: Int
    var body: [StoreItem]
}
