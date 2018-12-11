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
    var storeItemGorup = [StoreItemGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        appendItem()
    }
    
    private func appendItem() {
        let topics = ["main", "soup", "side"]
        for topic in topics {
            guard let mainItems = parse(topic: topic) else { continue }
            storeItemGorup.append(StoreItemGroup(sectionName: topic, sectionObjects: mainItems))
        }
    }
    
    private func parse(topic: String) -> [StoreItem]? {
        guard let jsonData = Parser.json(fileName: topic) else { return nil }
        guard let items = Parser.storeItems(from: jsonData) else { return nil }
        return items
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItemGorup[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath) as! StoreItemCell
        let items = storeItemGorup[indexPath.section].sectionObjects[indexPath.row]
        cell.configure(from: items)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItemGorup.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return storeItemGorup[section].sectionName
    }
}
