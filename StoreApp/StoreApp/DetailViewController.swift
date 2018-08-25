//
//  StoreItemDetailViewController.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

protocol DetailHashSettable {
    var detailHash: String { get }
}

class DetailViewController: UIViewController {
    
    private var detailHash: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setDetailHash(_ setter: DetailHashSettable) {
        self.detailHash = setter.detailHash
    }
}
