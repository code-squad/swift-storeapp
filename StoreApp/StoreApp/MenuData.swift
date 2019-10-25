//
//  TableData.swift
//  StoreApp
//
//  Created by Summer on 23/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import Foundation
import UIKit

class MenuDataSource : NSObject, UITableViewDataSource {
    var menuList = Array<MenuItem>()
    override init(){
        super.init()
        ["main", "soup", "side"].forEach{ v in
            self.loadData(fileName: v)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MenuCell
        let menu = menuList[indexPath.section]
        let item = menu[indexPath.row]!
        cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.title.text = item.title
        cell.desc.text = item.description
        cell.salePrice.attributedText = strokeLabel(text: item.n_price ?? "")
        cell.originalPrice.text = item.s_price
        item.badge?.forEach({ v in
            cell.badges.addArrangedSubview(badgeLabel(text:v))
        })
        return cell
    }
    private func badgeLabel(text:String) -> UILabelPadding{
        let label = UILabelPadding()
        label.text = text
        label.textColor = .white
        label.backgroundColor = UIColor(red: 119/255, green: 52/255, blue: 208/255, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }
    private func strokeLabel(text:String) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    private func loadData(fileName:String){
            let url = Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "json")!
            let jsonData = try? Data.init(contentsOf: url)
            let decoder = JSONDecoder()
            menuList.append(try! decoder.decode(MenuItem.self, from : jsonData!))
    }
}
