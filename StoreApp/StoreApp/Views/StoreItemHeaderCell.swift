//
//  StoreItemHeaderCell.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class StoreItemHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerCategories: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    
    func setupHeader() {
        headerCategories.layer.borderColor = UIColor.lightGray.cgColor
        headerCategories.layer.borderWidth = 1
    }
}
