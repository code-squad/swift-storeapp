//
//  DetailView.swift
//  StoreApp
//
//  Created by oingbong on 21/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class DetailView: UIView {
    @IBOutlet weak var thumbnailView: ThumbnailView!
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var detailSectionView: DetailSectionView!
    @IBOutlet weak var orderButton: UIButton!
    
    weak var delegate: Orderable?
    private let customer = "오잉봉"
    
    func configure(with item: DetailItem, title: String) {
        // MARK: Scroll View
        thumbnailView.configure(with: item)
        
        // MARK: Info
        descriptionView.configure(with: item, title: title)
        
        // MARK: Detail Section
        detailSectionView.configure(with: item)
    }
    
    // MARK: Click Button
    @IBAction func clickOrder(_ sender: Any) {
        guard let (title, price) = descriptionView.itemInfo() as? (String, String) else { return }
        let orderSheet = OrderSheet(customer: customer, price: price, menu: title)
        delegate?.orderToSlack(with: orderSheet)
    }
}
