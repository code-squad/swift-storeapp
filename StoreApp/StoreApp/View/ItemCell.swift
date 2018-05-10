//
//  ItemCell.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 25..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var eventBadge: UILabel!
    
    func set(_ item : Item) {
        title.text = item.title
        detail.text = item.description
        price.text = item.s_price
        eventBadge.text = item.badge?.reduce("", +)
    }
}
