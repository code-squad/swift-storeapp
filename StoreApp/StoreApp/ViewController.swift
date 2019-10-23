//
//  ViewController.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/21.
//  Copyright © 2019 hong3. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var ItemsTableVIew: UITableView!
    var items: [StoreItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = JsonHelper.loadItem()
        ItemsTableVIew.reloadData()
        // Do any additional setup after loading the view.
    }
}

extension ViewController{

}

extension ViewController: UITableViewDelegate{

}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell,
            let items = self.items, items.count > indexPath.row else { return UITableViewCell() }
        
        cell.labelTitle.text = items[indexPath.row].title
        cell.labelDescription.text = items[indexPath.row].Description
        cell.labelNprice.text = items[indexPath.row].nPrice
        cell.labelNprice.attributedText = cell.labelNprice.text?.strikeThrough()
        cell.labelSprice.text = items[indexPath.row].sPrice
        return cell
    }
}

