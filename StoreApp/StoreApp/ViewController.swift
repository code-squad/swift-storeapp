//
//  ViewController.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var storeTableView: UITableView!
    private let storeItemCellIdentifier = "storeItemCell"
    private var sectionInfo: SectionInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.dataSource = self
        self.sectionInfo = SectionInfo(categories: FoodCategory.allCases)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionInfo[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeItem = sectionInfo[indexPath.section][indexPath.row]
        guard let storeCell = tableView.dequeueReusableCell(withIdentifier: storeItemCellIdentifier, for: indexPath) as? StoreItemTableViewCell else {
            return UITableViewCell()
        }
        storeCell.set(storeItem: storeItem)
        return storeCell
    }
}
