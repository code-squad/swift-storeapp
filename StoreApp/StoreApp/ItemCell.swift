//
//  ItemCell.swift
//  StoreApp
//
//  Created by 한승희 on 22/10/2019.
//  Copyright © 2019 한승희. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var lableTitle: UILabel!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelSailPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
