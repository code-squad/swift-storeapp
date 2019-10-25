//
//  ViewController.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController {
    var item: Item = Item()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "MainTableViewCell",
                            bundle: nil)
            tableView.register(nib,
                               forCellReuseIdentifier: "menuCell")
            let sectionNib = UINib(nibName: "SectionCell",
                                   bundle: nil)
            tableView.register(sectionNib,
                               forCellReuseIdentifier: "sectionCell")
            tableView.delegate = item
            tableView.dataSource = item
        }
    }
}

