//
//  ItemCell.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/23.
//  Copyright © 2019 hong3. All rights reserved.
//

import UIKit

//MARK: - CustomCell
class ItemCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelSprice: UILabel!
    @IBOutlet weak var labelNprice: UILabel!
    @IBOutlet weak var badgeCollectionView: UICollectionView!
    var item: StoreItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension ItemCell {
    func config(model:StoreItem) {
        self.item = model
        self.labelTitle.text = model.title
        self.labelDescription.text = model.Description
        self.labelNprice.text = model.nPrice
        self.labelNprice.attributedText = self.labelNprice.text?.strikeThrough()
        self.labelSprice.text = model.sPrice
        self.badgeCollectionView.reloadData()
    }
}

extension ItemCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let models = self.item,
            let badgeItems = models.badge else { return 0 }
        return badgeItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemEventBadgeCell", for: indexPath) as? ItemEventBadgeCell,
            let badges = self.item.badge,
            badges.count > indexPath.row else { return ItemEventBadgeCell() }
        cell.badge.text = badges[indexPath.row]
        return cell
        
    }
}
