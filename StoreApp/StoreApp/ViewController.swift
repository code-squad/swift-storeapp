//
//  ViewController.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var storeItems: StoreItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        guard let jsonData = Parser.json(fileName: "main") else { return }
        guard let items = Parser.storeItems(from: jsonData) else { return }
        storeItems = StoreItems(data: items)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath) as! StoreItemCell
        guard let items = storeItems?[indexPath.row] else { return UITableViewCell(frame: CGRect(origin: .zero, size: .zero))}
        cell.configure(with: items)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
