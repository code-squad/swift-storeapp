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
    private var menuList = Array<StoreItem>()
    subscript(index: Int) -> StoreItem? {
        get {
            return menuList.count > index ? self.menuList[index] : nil
        }
        set(newValue) {
            self.menuList[index] = newValue!
        }
    }
    override init(){
        let url = Bundle.main.url(forResource: "main", withExtension: "json")!
        let jsonData = try? Data.init(contentsOf: url)
        let decoder = JSONDecoder()
        menuList = try! decoder.decode([StoreItem].self, from : jsonData!)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MenuCell
        let menuData = menuList[indexPath.row]
        cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.title.text = menuData.title
        cell.desc.text = menuData.description
        cell.salePrice.attributedText = strokeLabel(text: menuData.n_price ?? "")
        cell.originalPrice.text = menuData.s_price
        menuData.badge?.forEach({ v in
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
}
