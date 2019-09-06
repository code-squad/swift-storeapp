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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        Title = nil
        Description = nil
        Price = nil
    }
    
    func putInfo(_ storeItem: StoreItem) {
        self.Title.text = storeItem.title
        self.Description.text = storeItem.storeItemDescription
        self.Price.text = storeItem.nPrice
    }
}
