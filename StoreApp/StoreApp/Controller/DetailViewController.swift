//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 24..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailHash: String?

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var thumbnailsView: UIScrollView!
    @IBOutlet weak var detailInfoView: UIView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailPoint: UILabel!
    @IBOutlet weak var detailDeliveryInfo: UILabel!
    @IBOutlet weak var detailDeliveryFee: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
