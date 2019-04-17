//
//  StoreAppDelegate.swift
//  StoreApp
//
//  Created by 윤동민 on 11/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit
import Toaster

class StoreAppDelegate: NSObject, UITableViewDelegate {
    private var storeItems: StoreItems
    
    init(_ storeItems: StoreItems) {
        self.storeItems = storeItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreHeaderCell.identifier) as? StoreHeaderCell else { return UITableViewCell() }
        cell.set(at: section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ToastCenter.default.cancelAll()
        storeItems.access(of: indexPath.section, at: indexPath.row) { item in
            let itemDTO = item.getDTO()
            let toastText = """
            \(itemDTO.title)
            \(itemDTO.s_price)
            """
            Toast(text: toastText).show()
        }
    }
}
