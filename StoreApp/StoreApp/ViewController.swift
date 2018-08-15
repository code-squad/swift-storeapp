//
//  ViewController.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 13..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let headers = Headers().getHeaders()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 110
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headers[section].storeItems.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "itemCell"
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        itemCell.reset(headers[indexPath.section].storeItems[indexPath.row])
        return itemCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellIdentifier = "headerCell"
        guard let sectionHeader = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? HeaderCell else { return nil }
        sectionHeader.titleLabel.text = headers[section].title
        sectionHeader.descriptionLabel.text = headers[section].subTitle
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = 90
        return height
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollHeight = tableView.rowHeight
        
        if scrollView.contentOffset.y <= scrollHeight {
            if scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
            }
        } else if scrollView.contentOffset.y >= scrollHeight {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollHeight, 0, 0, 0)
        }
    }
    
}


