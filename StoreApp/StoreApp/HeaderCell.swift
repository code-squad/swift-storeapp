//
//  HeaderCell.swift
//  StoreApp
//
//  Created by Summer on 23/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//


import UIKit
class HeaderCell: UITableViewCell {
    @IBOutlet weak var category: UILabelPadding!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        category.sizeToFit()
        category.layer.borderColor = UIColor.lightGray.cgColor
        category.layer.borderWidth = 1
    }
    
    func setData(title:String, category:String){
        self.title.text = title
        self.category.text = category
    }
}
