//
//  StoreItemViewController.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit
import Toaster

class StoreItemViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    private let tableViewModel = TableViewModel()
    private let networkModule = NetworkModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData), name: NSNotification.Name(rawValue: "getData"), object: nil)
        
        tableview.dataSource = tableViewModel
        tableview.delegate = self
        tableview.separatorStyle = .none
    }
    
    @objc fileprivate func onDidReceiveData(_ notification: Notification) {
        guard let userInfoDict = notification.userInfo, let storeItems = userInfoDict["storeItems"] else { return }
        tableViewModel.storeItemsArray.append(storeItems as! [StoreItem])
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func updateTableView(indexPath: Int) {
        tableview.reloadSections(IndexSet(integer: indexPath), with: .right)
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    private func showToaster(title: String, price: String) {
        let toast = Toast(text: "\(title)은 \(price)입니다.")
        toast.show()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storeItem = tableViewModel.itemOf(section: indexPath.section, row: indexPath.row)
        showToaster(title: storeItem.title, price: storeItem.sPrice)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! StoreItemHeaderCell
        cell.setupHeader(networkModule.jsonFilenames[section])
        return cell
    }
    
    //MARK:- Height of Header, Row
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}
