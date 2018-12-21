//
//  DetailView.swift
//  StoreApp
//
//  Created by oingbong on 21/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class DetailView: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var detailSection: UIScrollView!
    @IBOutlet weak var orderButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var pointTitleLabel: UILabel!
    @IBOutlet weak var deliveryInfoTitleLabel: UILabel!
    @IBOutlet weak var deliberyFeeTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    
    func configure(with item: DetailItem) {
        
    }
}
