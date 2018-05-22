//
//  ItemCell.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 25..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var eventBadge: UILabel!
    
    func set(_ item : Item) {
        title.text = item.title
        detail.text = item.description
        price.text = item.s_price
        eventBadge.text = item.badge?.reduce("", +)
        setMenuImage(item.image)
    }
    
    private func setMenuImage(_ menuImageURL: String ) {
        guard let documentDirectoryPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        guard let imageURL = URL(string: menuImageURL) else { return }
        let fileURL = documentDirectoryPath.appendingPathComponent(imageURL.lastPathComponent)
        if FileManager.default.fileExists (atPath: fileURL.path) {
            guard let data = FileManager.default.contents(atPath: fileURL.path) else { return }
            menuImage.image = UIImage(data: data)
        } else {
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: imageURL) else { return }
                FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
                DispatchQueue.main.async {
                    self.menuImage.image = UIImage(data: data)
                }
            }
        }
    }
}
