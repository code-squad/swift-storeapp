//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 17..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var naturalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var thumbScrollView: UIScrollView!
    @IBOutlet weak var detailStackView: UIStackView!
    
    weak var delegate: DetailViewControllerDelegate?
    var detailPresenter: DetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchUpOrderButton(_ sender: UIButton) {
        delegate?.post(orderMessage: "")
        self.navigationController?.popViewController(animated: true)
    }
}
