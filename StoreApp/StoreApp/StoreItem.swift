//
//  StoreItem.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

class StoreItem: Decodable {
    private var detail_hash: String
    private var image: String
    private var alt: String
    private var delivery_type: [String]
    private var title: String
    private var description: String
    private var n_price: String?
    private var s_price: String
    private var badge: [String]?
    
    func access(form: (String, String, String, [String], String, String, String?, String, [String]?) -> Void) {
        form(detail_hash, image, alt, delivery_type, title, description, n_price, s_price, badge)
    }
}
