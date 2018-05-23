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
    @IBOutlet weak var price: PriceView!
    @IBOutlet weak var eventBadge: EventBadgeView!
    
    func set(_ item : Item) {
        title.text = item.title
        detail.text = item.description
        price.setPriceLabels(item)
        if let badge = item.badge {
            eventBadge.setBadges(badge)
        }
        setMenuImage(item.image)
    }
    
    private func setMenuImage(_ menuImageURL: String ) {
        guard let fileURL = Downloader.generateFileURL(menuImageURL) else { return }
        if Downloader.isExistantFileAt(fileURL) {
            guard let data = Downloader.loadData(fileURL) else { return }
            menuImage.image = UIImage(data: data)
        } else {
            DispatchQueue.global().async {
                guard let data = Downloader.savdData(menuImageURL, fileURL) else { return }
                DispatchQueue.main.async {
                    self.menuImage.image = UIImage(data: data)
                }
            }
        }
    }
}
