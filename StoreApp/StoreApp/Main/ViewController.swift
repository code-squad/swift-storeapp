//
//  ViewController.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var item: Item = Item()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "MainTableViewCell",
                            bundle: nil)
            tableView.register(nib,
                               forCellReuseIdentifier: "menuCell")
            let sectionNib = UINib(nibName: "SectionCell", bundle: nil)
            tableView.register(sectionNib,
                               forCellReuseIdentifier: "sectionCell")
            item.items = decode()
            tableView.dataSource = item
            tableView.delegate = item
        }
    }
    
    func decode ()  -> [Foods]?{
        let decoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "main") else { return nil }
        do {
            return try decoder.decode([Foods].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

