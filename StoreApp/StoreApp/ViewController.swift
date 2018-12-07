//
//  ViewController.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var storeItems: StoreItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let jsonData = Parser.json(fileName: "main") else { return }
        guard let items = Parser.storeItems(from: jsonData) else { return }
        storeItems = StoreItems(data: items)
    }
}
