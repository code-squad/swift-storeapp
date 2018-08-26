//
//  DetailView.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
    func orderButtonDidTapped(_ orderButton: UIButton)
}

class DetailView: UIView {
    
    weak var delegate: DetailViewDelegate?
    
    @IBAction func orderItem(_ sender: UIButton) {
        delegate?.orderButtonDidTapped(sender)
    }
}
