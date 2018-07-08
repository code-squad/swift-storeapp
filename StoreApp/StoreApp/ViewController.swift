//
//  ViewController.swift
//  StoreApp
//
//  Created by 백인철 on 2018. 7. 8..
//  Copyright © 2018년 Incheol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellId = "MenuTableViewCell"
    var storeArray: [StoreItems] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        storeArray.append(StoreItems(storeInfo: StoreInfo(id: "main", title: "메인반찬", description: "한그릇 뚝딱 메인 요리")))
        storeArray.append(StoreItems(storeInfo: StoreInfo(id: "soup", title: "국.찌게", description: "김이 모락모락 국.찌게")))
        storeArray.append(StoreItems(storeInfo: StoreInfo(id: "side", title: "밑반찬", description: "언제 먹어도 든든한 밑반찬")))
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuTableViewCell
        cell.storeItem = storeArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        headerView.descriptionLabel.text = storeArray[section].storeInfo.description
        headerView.titleLabelText(text: storeArray[section].storeInfo.title ?? "")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ViewController: UITableViewDelegate {
    
}
