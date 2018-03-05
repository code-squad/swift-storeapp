//
//  ViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var items = [StoreItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let data = JSONParser.getDataFromJSONFile("main")
        self.items = JSONParser.decode(data: data, toType: [StoreItem].self)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentRowData: StoreItem = self.items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ItemCell else {
            return UITableViewCell()
        }
        cell.title.text = currentRowData.title
        cell.titleDescription.text = currentRowData.description
        cell.pricesContainer.normalPrice?.attributedText = currentRowData.normalPrice?.strike
        cell.pricesContainer.salePrice.attributedText = currentRowData.salePrice.salesHighlight
        cell.badges?.appendItems(with: currentRowData.badges)
        return cell
    }

}
