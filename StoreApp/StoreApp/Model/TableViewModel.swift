//
//  TableViewModel.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/23.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class TableViewModel: NSObject, UITableViewDataSource {
    private var storeItems = Array<StoreItem>()
    
    override init() {
        super.init()
    
        decodeJSON()
    }
    
    fileprivate func decodeJSON() {
        guard let url = Bundle.main.url(forResource: "main", withExtension: "json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to request data", err)
            }
            
            guard let data = data else { return }
            
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
