//
//  ViewController.swift
//  StoreApp
//
//  Created by 백인철 on 2018. 7. 8..
//  Copyright © 2018년 Incheol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var storeItems: StoreItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        storeItems = StoreItems()
        
        // print(storeItems[1].title)
        // Optional("[빅마마의밥친구] 아삭 고소한 연근고기조림 250g")
    }
}

