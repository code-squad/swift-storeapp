//
//  ViewController.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var storeTableView: UITableView!
    
    private var storeItemList: StoreItemList!

    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.delegate = self
        storeTableView.dataSource = self
        self.storeItemList = StoreItemList()
    }
}
