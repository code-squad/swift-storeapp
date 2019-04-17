//
//  StoreItemDetailViewController.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 16..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os.log

class StoreItemDetailViewController: UIViewController {
    
    var detailHash = ""
    
    var detailView = StoreItemDetailView()
    
    func prepare(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.detailHash = detailHash
        
        os_log("detailHash : %@",self.detailHash)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
