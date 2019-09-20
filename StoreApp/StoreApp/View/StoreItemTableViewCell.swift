//
//  StoreItemTableViewCell.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/7/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class StoreItemTableViewCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var nPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        Title.text = nil
        Description.text = nil
        Price.text = nil
        nPrice.text = nil
    }
    
    func putInfo(_ storeItem: StoreItem) {
        self.Title.text = storeItem.title
        self.Description.text = storeItem.storeItemDescription
        self.Price.text = storeItem.sPrice
        
        if let nPrice = storeItem.nPrice {
            self.nPrice.text = nPrice
        }
    }
}
