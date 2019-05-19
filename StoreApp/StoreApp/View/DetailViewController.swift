//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 17..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
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
