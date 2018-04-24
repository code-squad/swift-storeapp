//
//  StoreItem.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class StoreItem: Decodable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badge: [String]?
    private(set) var menuImage: MenuImage?

    func setMenuImage(row: Int, section: Int) {
        menuImage = MenuImage(urlString: self.image, row: row, section: section)
    }
}
