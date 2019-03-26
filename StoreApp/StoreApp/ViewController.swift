//
//  ViewController.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController {
    
    @IBOutlet weak var storeItemTableView: UITableView!
    
    private let dataSourceObject = DataSourceObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.storeItemTableView.rowHeight  = view.bounds.height / 6
        
        self.storeItemTableView.dataSource = dataSourceObject
        
        
        // end of viewDidLoad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

