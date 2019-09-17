//
//  ViewController.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/6/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let storeItemDataSrouce = StoreItemDataSource()
    @IBOutlet weak var storeItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeItemTableView.dataSource = storeItemDataSrouce
    }
}

