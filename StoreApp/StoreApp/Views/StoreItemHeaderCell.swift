//
//  StoreItemHeaderCell.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class StoreItemHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerCategories: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    
    func setupHeader(_ sectionName: String) {
        headerCategories.layer.borderColor = UIColor.lightGray.cgColor
        headerCategories.layer.borderWidth = 1
        
        var categoryName: String = ""
        var title: String = ""
        
        switch sectionName {
        case "main":
            categoryName = "메인반찬"
            title = "한그릇 뚝딱 메인 요리"
        case "soup":
            categoryName = "국・찌개"
            title = "김이 모락모락 국.찌개"
        case "side":
            categoryName = "밑반찬"
            title = "언제 먹어도 든든한 밑반찬"
        default:
            break
        }
        
        headerCategories.setTitle(" \(categoryName) ", for: .normal)
        headerTitle.text = title
    }
}
