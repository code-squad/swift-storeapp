//
//  StoreTableView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

protocol StoreTableViewController: UIViewController {
    func reload(section: Int)
    func reload(indexPath: IndexPath)
}
