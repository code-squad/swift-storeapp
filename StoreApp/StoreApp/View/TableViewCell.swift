//
//  TableViewCell.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 28..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var badges: BadgesView!
    @IBOutlet weak var foodimageView: UIImageView?
}
