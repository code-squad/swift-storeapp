//
//  UnreachableViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 8. 6..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class UnreachableViewController: UIViewController {

    @IBOutlet weak var noNetworkLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        noNetworkLabel.text = ProgramDescription.UnreachableNetworkInKorean.rawValue
    }

}
