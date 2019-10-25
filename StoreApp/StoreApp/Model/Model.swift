//
//  Model.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//
import UIKit
import Toaster

class Item: NSObject {
    var items: [Foods]?
    
    subscript(index: Int) -> Foods? {
        return items?[index]
    }
    
    override init() {
        super.init()
        items = decode()
    }
    
    func setCellConfigure(food: Foods, indexPath: IndexPath, cell: MainTableViewCell) {
        let storeItem = food[indexPath.row]
        cell.titleLabel.text = storeItem.title
        cell.detailLabel.text = storeItem.description
        cell.sPriceLabel.text = storeItem.sPrice
        cell.setNPrice(nPrice: storeItem.nPrice)
        requestURL(text: storeItem.image) { image in
            cell.cellImageVIew.image = image
        }
    }
    
    func decode ()  -> [Foods]?{
        let decoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "main") else { return nil }
        do {
            return try decoder.decode([Foods].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
            return nil
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
        } else {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = items else { return }
        // Toast가 지금 버그가 있어서 화면에 제대로 보여주는지는 확인하지 못했습니다.
        if indexPath.section == 0 {
            let message = items[0].item[indexPath.row].sPrice
            Toast(text: message, delay: 0, duration: 2).show()
        } else if indexPath.section == 1 {
            let message = items[1].item[indexPath.row].sPrice
            Toast(text: message, delay: 0, duration: 2).show()
        } else {
            let message = items[2].item[indexPath.row].sPrice
            Toast(text: message, delay: 0, duration: 2).show()
        }
    }
}
