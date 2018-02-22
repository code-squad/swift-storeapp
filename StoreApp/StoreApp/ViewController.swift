//
//  ViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var items = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        setData(section: .main, jsonFileName: "main")
        setData(section: .soup, jsonFileName: "soup")
        setData(section: .side, jsonFileName: "side")
        tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
    }

    private func setData(section: TableSection, jsonFileName: String) {
        let data = JSONParser.getDataFromJSONFile(jsonFileName)
        let item = JSONParser.decode(data: data, toType: [StoreItem].self)
        let section = Section(section: section, data: item)
        items.append(section)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.items[indexPath.section].cell[indexPath.row]
        ToastView.appearance().font = UIFont.boldSystemFont(ofSize: 15)
        let toaster = Toast(text: row.title+"\n"+row.salePrice)
        toaster.show()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].cell.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell else {
            return nil
        }
        header.title.text = items[section].title
        header.subtitle.text = items[section].subtitle
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.items[indexPath.section].cell[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ItemCell else {
            return UITableViewCell()
        }
        cell.title.text = row.title
        cell.titleDescription.text = row.description
        cell.pricesContainer.normalPrice?.attributedText = row.normalPrice?.strike
        cell.pricesContainer.salePrice.attributedText = row.salePrice.salesHighlight
        cell.badges?.appendItems(with: row.badges)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell else {
            return 0.0
        }
        return header.frame.height
    }

}
