//
//  StoreView.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 12/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import UIKit


// # MARK: - View

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var subheadLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    
    var tagViews: [UILabel] = []
    var imageURL: URL?
    
    func setProductInfo(info: StoreItem) {
        headLabel.text = info.title
        subheadLabel.text = info.description
        originalPriceLabel.text = "7,500"
        salePriceLabel.text = info.s_price
        
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
        mainImageView.layer.masksToBounds = true
        
        
        tagViews.forEach { tagView in tagView.removeFromSuperview() }
        tagViews = []
        let fixedHeight: CGFloat = 22
        var labelX = headLabel.frame.origin.x
        let labelY = salePriceLabel.frame.origin.y + salePriceLabel.frame.height + 6.0
        let labelGap: CGFloat = 3.0
        let labelMargin: CGFloat = -2.0
        for deliveryType in info.delivery_type {
            let label = UILabel(frame: .zero)
            label.text = deliveryType
            label.backgroundColor = UIColor(red: 170.0/255.0, green: 116.0/255.0, blue: 191.0/255.0, alpha: 1.0)
            label.sizeToFit()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textColor = .white
            
            label.frame = CGRect(x: labelX, y: labelY,
                                 width: label.frame.width + labelMargin*2,
                                 height: fixedHeight)
            self.addSubview(label)
            tagViews.append(label)
            
            labelX += label.frame.width + labelGap
        }
        
        if let imageURL = URL(string: info.image) {
            self.loadImage(with: imageURL)
        }
    }
    
    func loadImage(with url: URL) {
        self.imageURL = url
        mainImageView.image = nil
        
        if let imageFromCache = CacheManager.shared.object(forKey: url as AnyObject) as? UIImage {
            mainImageView.image = imageFromCache
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error { print(error); return }
                DispatchQueue.main.async(execute: {
                    if let unwrappedData = data,
                        let imageToCache = UIImage(data: unwrappedData) {
                        if self.imageURL == url {
                            self.mainImageView.image = imageToCache
                        }
                        CacheManager.shared.setObject(imageToCache, forKey: url as AnyObject)
                    }
                })
            }).resume()
        }
    }
}


class StoreSectionHeader: UITableViewCell {
    @IBOutlet weak var subtitleLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        subtitleLabel.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        subtitleLabel.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        // cell 재사용전에 호출되는 함수
        subtitleLabel.setTitle("", for: .normal)
        titleLabel.text = ""
    }
    
    func set(info sectionInfo: StoreSection?) {
        if let info = sectionInfo {
            subtitleLabel.setTitle(info.subtitle, for: .normal)
            titleLabel.text = info.title
        }
    }
}


class CacheManager: NSCache<AnyObject, AnyObject> {
    static let shared = CacheManager()
}
