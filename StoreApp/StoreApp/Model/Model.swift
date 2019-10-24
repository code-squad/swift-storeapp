//
//  Model.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//
import UIKit

class Item: NSObject {
    var items: [Foods]?
    
    subscript(index: Int) -> Foods? {
        return items?[index]
    }
    
    func setCellConfigure(food: Foods, indexPath: IndexPath, cell: MainTableViewCell) {
        let storeItem = food[indexPath.row]
        cell.titleLabel.text = storeItem.title
        cell.detailLabel.text = storeItem.description
        cell.sPriceLabel.text = storeItem.sPrice
        cell.setNPrice(nPrice: storeItem.nPrice)
        DispatchQueue.main.async {
            cell.cellImageVIew.image = request(text: storeItem.image)
        }
    }

}

extension Item: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let item = items else { return 0 }
        return item.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        let item = items[section]
        return item.item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MainTableViewCell, let items = items else { return UITableViewCell() }
        if indexPath.section == 0 {
            setCellConfigure(food: items[0], indexPath: indexPath, cell: cell)
        } else if indexPath.section == 1 {
            setCellConfigure(food: items[1], indexPath: indexPath, cell: cell)
        } else if indexPath.section == 2 {
            setCellConfigure(food: items[2], indexPath: indexPath, cell: cell)
        }
        return cell
    }
}


extension Item: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as? SectionCell,
            let items = items else { return UIView() }
        sectionCell.backgroundColor = .white
        sectionCell.sectionTitleLabel.text = items[section].sectionHeader
        sectionCell.sectionDetailLabel.text = items[section].sectionDetail
        return sectionCell
    }
}
