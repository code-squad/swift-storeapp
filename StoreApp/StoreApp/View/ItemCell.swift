//
//  ItemCell.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 13..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    var imageData = ImageData()
    
    
    func set(_ item: StoreItem) {
        itemTitle.text = item.title
        itemDescription.text = item.description
        sPrice.text = item.sPrice
        fetchItemImages(item.image)
        
        if let price = item.nPrice {
            nPrice.text = price
            nPrice.isHidden = false
        } else {
            nPrice.isHidden = true
        }
        
        guard let badges = item.badge else { return }

        for badge in badges {
            let newBadge = UILabel(frame: .zero)
            newBadge.text = badge
            newBadge.backgroundColor = .purple
            newBadge.textColor = .white
            badgeStackView.addArrangedSubview(newBadge)
        }
        
    }
    
    func fetchItemImages(_ imageURL: String) {
        guard let fileURL = imageData.makeImageURL(imageURL) else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            guard let data = imageData.loadImageData(fileURL) else { return }
            self.itemImage.image = UIImage(data: data)
        } else { //파일이 없을경우 파일 생성후 데이터 저장
            DispatchQueue.global().async {
                guard let data = self.imageData.saveImageData(imageURL, fileURL) else { return }
                DispatchQueue.main.async {
                    self.itemImage.image = UIImage(data: data)
                }
            }
        }
    }

    override func prepareForReuse() {
        self.badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
}
