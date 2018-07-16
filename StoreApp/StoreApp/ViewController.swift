//
//  ViewController.swift
//  StoreApp
//
//  Created by 백인철 on 2018. 7. 8..
//  Copyright © 2018년 Incheol. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController {

    let cellId = "MenuTableViewCell"
    var store: Store = {
        return Store()
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.didReceiveStoreData(notification:)),
                                               name: NSNotification.Name("did_receive_json"), object: nil)
    }
    
    @objc func didReceiveStoreData(notification: NSNotification) {
        guard let id = notification.object as? String else {
            return
        }
        let index = store.storeInfoArray.index { storeInfo -> Bool in
            return storeInfo.id == id
        }
        if let section = index {
            DispatchQueue.main.async {
                self.tableView.reloadSections([section], with: UITableViewRowAnimation.none)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuTableViewCell
        cell.storeItem = store[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
        headerView.descriptionLabel.text = store[section].description
        headerView.titleLabelText(text: store[section].title ?? "")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storeItem = store[indexPath.section][indexPath.row]
        let text = "\(storeItem.title ?? "") \(storeItem.s_price ?? "")"
        Toast(text: text).show()
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
