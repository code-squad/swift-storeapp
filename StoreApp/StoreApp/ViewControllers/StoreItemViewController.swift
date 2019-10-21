//
//  StoreItemViewController.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class TableViewModel: NSObject, UITableViewDataSource {
//    var storeItemsArray = Array<Dictionary<String, Any>>()
    var storeItems = Array<StoreItem>()
    
    override init() {
        super.init()
    
        decodeJSON()
    }
    
    fileprivate func decodeJSON() {
        guard let url = Bundle.main.url(forResource: "main", withExtension: "json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
                    guard let data = data else { return }
                    
                    // endcoding String
        //            let dataAsString = String(data: data, encoding: .utf8)
        //            print(dataAsString!)
                    
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        self.storeItems = try jsonDecoder.decode([StoreItem].self, from: data)
                    } catch let jsonErr {
                        print("Error in Serialization", jsonErr)
                    }
                }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! StoreItemCell
        cell.item = storeItems[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

class StoreItemViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var storeItemTableView: UITableView!
    let tableViewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storeItemTableView.dataSource = tableViewModel
        storeItemTableView.delegate = self
        storeItemTableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! StoreItemHeaderCell
        cell.setupHeader()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //MARK:- Height of Header, Row
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    //MARK:- TableView DataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! StoreItemCell
//        return cell
//    }
}
