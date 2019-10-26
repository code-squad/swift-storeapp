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
    var items: [Foods] = []
    var tbView: UITableView = UITableView()
    
    subscript(index: Int) -> Foods? {
        return items[index]
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
}

extension Item: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tbView = tableView
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = items[section]
        return item.body.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
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
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as? SectionCell else { return UIView() }
        sectionCell.backgroundColor = .white
        if items[section].body.first?.title == "[미노리키친] 규동 250g" {
            sectionCell.sectionTitleLabel.text = "메인반찬"
            sectionCell.sectionDetailLabel.text = "한그릇 뚝딱 메인 요리"
        } else if items[section].body.first?.title == "[수하동] 특곰탕 850g" {
            sectionCell.sectionTitleLabel.text = "국.찌게"
            sectionCell.sectionDetailLabel.text = "김이 모락모락 국.찌게"
        } else {
            sectionCell.sectionTitleLabel.text = "밑반찬"
            sectionCell.sectionDetailLabel.text = "언제 먹어도 든든한 밑반찬"
        }
        return sectionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Toast가 지금 버그가 있어서 화면에 제대로 보여주는지는 확인하지 못했습니다.
        if indexPath.section == 0 {
            let message = items[0].body[indexPath.row].sPrice
            Toast(text: message, delay: 0, duration: 2).show()
        } else if indexPath.section == 1 {
            let message = items[1].body[indexPath.row].sPrice
            Toast(text: message, delay: 0, duration: 2).show()
        } else {
            let message = items[2].body[indexPath.row].sPrice
            Toast(text: message, delay: 0, duration: 2).show()
        }
    }
}
