//
//  UITableView+.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<Cell: Reusable>(with cellType: Cell.Type,
                                             for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? Cell
    }
}
