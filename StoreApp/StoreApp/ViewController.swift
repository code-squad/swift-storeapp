//
//  ViewController.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/6/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var storeItems: StoreItems?
    @IBOutlet weak var storeItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeItems = JsonReceiver.getJson()
        storeItemTableView.delegate = self
        storeItemTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeItemCell", for: indexPath) as! StoreItemTableViewCell
        
        if let storeItem = storeItems?[indexPath.row] {
            cell.putInfo(storeItem)
        }
        
        return cell
    }
}

