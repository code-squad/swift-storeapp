//
//  StoreItemTableViewCell.swift
//  StoreApp
//
//  Created by rk on 2018. 7. 8..
//  Copyright © 2018년 fryb. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemSalePriceLabel: UILabel!
    @IBOutlet weak var itemBadgeLabel1: UILabel!
    @IBOutlet weak var itemBadgeLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(cell:StoreItemCell, storeItem: StoreModel.StoreItem)->StoreItemCell{
        // cell 채워넣는 부분
        cell.itemTitleLabel.text = storeItem.title
        cell.itemDescriptionLabel.text = storeItem.description
        cell.itemPriceLabel.text = storeItem.s_price
        cell.itemSalePriceLabel.text = storeItem.s_price
        // badge 개수에 따라 ui처리
        if(storeItem.badge != nil){
            // badge 1개 이상
            cell.itemBadgeLabel1.text = storeItem.badge?[0]
            if((storeItem.badge?.count)! > 1){
                cell.itemBadgeLabel2.text = storeItem.badge?[1]
            }
            else{
                cell.itemBadgeLabel2.isHidden = true
            }
        }
        else{
            // badge 0개. 안보이게 처리.
            cell.itemBadgeLabel1.isHidden = true
            cell.itemBadgeLabel2.isHidden = true
        }
        return cell
    }
}
