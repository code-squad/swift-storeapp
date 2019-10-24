//
//  TableViewModel.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/23.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

struct BaseAPIResponse<StoreItem: Decodable>: Decodable {
    let statusCode: Int
    let body: [StoreItem]
}

class TableViewModel: NSObject, UITableViewDataSource {
    private let defaultSession = URLSession(configuration: .default)
    private let session = URLSession.shared
    var storeItemViewController: StoreItemViewController?
    
    private var storeItemsArray = Array<Array<StoreItem>>() {
        didSet {
            print("storeItemsArray. index:", self.storeItemsArray.count - 1)
            storeItemViewController?.updateTableView()
//            storeItemViewController?.updateTableView(indexPath: self.storeItemsArray.count - 1)
        }
    }
    
    override init() {
        super.init()
    
        decodeJSON()
    }
    
    let jsonFilenames = ["main", "soup", "side"]
    let jsonUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
    
    fileprivate func decodeJSON() {
        let URLComponentsArray = jsonFilenames.map({ jsonUrl + $0 }).map({ URLComponents(string: $0) })
        
        URLComponentsArray.map({ $0?.url }).forEach { (url) in
            guard let url = url else { return }
            
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let baseAPIResponse = try jsonDecoder.decode(BaseAPIResponse<StoreItem>.self, from: data)
                    self.storeItemsArray.append(baseAPIResponse.body)
                
                } catch let jsonErr {
                    print("Error in decoding json", jsonErr)
                }
            }.resume()
        }
    }
    
    func itemOf(section: Int, row: Int) -> StoreItem {
        return storeItemsArray[section][row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSection:", storeItemsArray.count)
        return storeItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return storeItemsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! StoreItemCell
        cell.item = storeItemsArray[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
