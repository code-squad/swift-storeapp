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
    
    func configureCellFromArray(cell:StoreItemCell, itemArray: Array<StoreModel.StoreItem>, rowNumber:Int)->StoreItemCell{
        cell.itemTitleLabel.text = itemArray[rowNumber].title
        cell.itemDescriptionLabel.text = itemArray[rowNumber].description
        cell.itemPriceLabel.text = itemArray[rowNumber].s_price
        cell.itemSalePriceLabel.text = itemArray[rowNumber].s_price
        // badge 개수에 따라 ui처리
        if(itemArray[rowNumber].badge != nil){
            // badge 1개 이상
            cell.itemBadgeLabel1.text = itemArray[rowNumber].badge?[0]
            if((itemArray[rowNumber].badge?.count)! > 1){
                cell.itemBadgeLabel2.text = itemArray[rowNumber].badge?[1]
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
