//
//  ViewController.swift
//  StoreApp
//
//  Created by Summer on 23/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let menuModel = MenuDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        tableView.delegate = self
        tableView.dataSource = menuModel
        Toast(text: "hi").show()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        let headerData = menuModel.menuList[section]
        header.setData(title: headerData.title, category: headerData.category)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuModel.menuList[indexPath.section][indexPath.row]
        Toast(text: "\(item?.title) : \(item?.s_price)").show()
    }
}

