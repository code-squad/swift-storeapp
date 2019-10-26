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
            requestJson(text: "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main") { food in
                self.item.items.append(food)
                self.tableView.reloadData()
            }
            requestJson(text: "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup") { food in
                self.item.items.append(food)
                self.tableView.reloadData()
            }
            requestJson(text: "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/side") { food in
                self.item.items.append(food)
                self.tableView.reloadData()
            }
        }
    }
    
    func sendTableView(completion: @escaping (UITableView) -> Void) {
        completion(tableView)
    }
}

