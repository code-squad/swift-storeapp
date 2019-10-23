//
//  StoreItemViewController.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class StoreItemViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var storeItemTableView: UITableView!
    let tableViewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storeItemTableView.dataSource = tableViewModel
        storeItemTableView.delegate = self
        storeItemTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! StoreItemHeaderCell
        cell.setupHeader()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //MARK:- Height of Header, Row
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}
