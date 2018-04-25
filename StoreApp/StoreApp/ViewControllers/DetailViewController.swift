//
//  DetailViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 24..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var detailHash: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailViewController: DetailinfoDelegate {
    func order() {

    }
}
