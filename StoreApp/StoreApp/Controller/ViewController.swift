//
//  ViewController.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 21..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var sections : Sections = Sections()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(updateSection(notification:)), name: .reloadItems, object: nil)
    }
    
    @objc func updateSection(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let sectionHeader = userInfo[Keyword.Observer.sectionType.name]  as? Section.Header else { return }
            self.tableView.insertRows(at: self.sections.generateIndexPaths(sectionHeader), with: .none)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].storeItems.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: Keyword.headerCell.name) as? HeaderCell
        header?.title.text = sections[section].title
        header?.subTitle.text = sections[section].subTitle
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Keyword.Size.header.value)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: Keyword.listCell.name, for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        itemCell.set(sections.getItem(indexPath))
        return itemCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections.getItem(indexPath)
        Toast(text: item.title + "\n" + item.s_price).show()
    }

}
