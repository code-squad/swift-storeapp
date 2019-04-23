//
//  StoreTableViewHeaderView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 23..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class StoreTableViewHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var sectionDescriptionLabel: UILabel!
    
    
    //MARK: Type
    static let nibName = "StoreTableViewHeaderView"
    static let identifier = "storeTableViewHeaderView"
    
    //MARK: 
    override var reuseIdentifier: String? {
        return "storeTableViewHeaderView"
    }
}
