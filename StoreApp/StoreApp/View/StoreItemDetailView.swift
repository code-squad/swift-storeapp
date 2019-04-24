//
//  StoreItemDetailView.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 15..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class StoreItemDetailView: UIView {
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var adCopy:UILabel!
    @IBOutlet weak var n_price:UILabel!
    @IBOutlet weak var s_price:UILabel!
    @IBOutlet weak var point:UILabel!
    @IBOutlet weak var delivery_type:UILabel!
    @IBOutlet weak var delivery_price:UILabel!

    
    func setting(model: StoreItemDetailModel){
        DispatchQueue.main.async {            
            self.adCopy.text = model.product_description
            self.point.text = model.point
            self.delivery_price.text = model.delivery_fee
            self.title.text = model.title
            self.n_price.text = model.n_price
            self.s_price.attributedText = MyStyleMaker.makeStrikeThrough(text: model.s_price)
            
        }
    }
    
    
}
