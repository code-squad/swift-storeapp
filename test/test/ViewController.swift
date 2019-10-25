//
//  ViewController.swift
//  test
//
//  Created by Cloud on 2019/10/25.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btn(_ sender: Any) {
        Toast(text: "Hello, world!", delay: Delay.short, duration: Delay.long).show()
    }
    

}

