//
//  ViewController.swift
//  StoreApp
//
//  Created by Summer on 23/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let menuModel = MenuDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        tableView.delegate = self
        tableView.dataSource = menuModel
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        header.category?.text = "국, 찌개"
        header.title?.text = "김이 모락 모락나는 국, 찌개"
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

