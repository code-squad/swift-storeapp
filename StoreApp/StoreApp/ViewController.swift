//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let storeAppDataSource = StoreAppDataSource()
    private let storeAppDelegate = StoreAppDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = storeAppDataSource
        tableView.delegate = storeAppDelegate
    }
}
