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
    private var storeItemList: StoreItemList!

    private func setStoreItemListData() {
        guard let loaded = JSONParser.parseFromAsset(fileName: "main", dataType: [StoreItem].self) else { return }
        storeItemList = StoreItemList(storeItems: loaded)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.dataSource = self
        setStoreItemListData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeItem = storeItemList[indexPath.row]
        guard let storeCell = tableView.dequeueReusableCell(withIdentifier: storeItemCellIdentifier, for: indexPath) as? StoreItemTableViewCell else {
            return UITableViewCell()
        }
        storeCell.set(storeItem: storeItem)
        return storeCell
    }
}
