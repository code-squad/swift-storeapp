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
    var topic = [Topic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        appendTopic()
        appendItem()
    }
    
    private func appendTopic() {
        let main = Topic(englihsName: "main", koreanName: "메인반찬", desc: "한그릇 뚝딱 메인 요리")
        let soup = Topic(englihsName: "soup", koreanName: "국.찌게", desc: "김이 모락모락 국.찌게")
        let side = Topic(englihsName: "side", koreanName: "밑반찬", desc: "언제 먹어도 든든한 밑반찬")
        topic.append(main)
        topic.append(soup)
        topic.append(side)
    }
    
    private func appendItem() {
        for item in topic {
            guard let mainItems = parse(topic: item.englihsName) else { continue }
            storeItemGorup.append(StoreItemGroup(sectionName: item.englihsName, sectionObjects: mainItems))
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

// for Section
extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItemGorup.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return storeItemGorup[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreHeaderCell") as! StoreHeaderCell
        cell.configure(from: topic[section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
