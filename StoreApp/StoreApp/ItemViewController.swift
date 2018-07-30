//
//  ItemViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 29..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var ItemImages: UIScrollView!
    @IBOutlet weak var titleLabels: UIStackView!
    @IBOutlet weak var detailLabels: UIStackView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var detailView: UIScrollView!
    var itemHashData: DetailItemInfo!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
