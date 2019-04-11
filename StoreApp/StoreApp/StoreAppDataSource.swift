//
//  StoreAppDataSource.swift
//  StoreApp
//
//  Created by 윤동민 on 11/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class StoreAppDataSource: NSObject, UITableViewDataSource {
    private var row: Int = 0
    private var cellInformation: [StoreItemDTO] = []
    
    func set(row: Int) {
        self.row = row
    }
    
    func setCell(information: [StoreItemDTO]) {
        self.cellInformation = information
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseQueue", for: indexPath) as? StoreItemCell else { return UITableViewCell() }
        cell.set(cellInformation[indexPath.row])
        return cell
    }
}
