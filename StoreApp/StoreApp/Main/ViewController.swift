//
//  ViewController.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let item = Item()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "menuCell")
            item.items = decode()
            tableView.dataSource = item
            tableView.delegate = self
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

