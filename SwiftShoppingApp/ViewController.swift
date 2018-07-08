//
//  ViewController.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 08/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sectionHeaderSubtitleLabel: UIButton!
    @IBOutlet weak var sectionHeaderTitleLabel: UILabel!
    
    var myitems: Array<StoreItem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myitems = []
        
        // main.json 불러와서 파싱
        if let filePath = Bundle.main.path(forResource: "main", ofType: "json"),
            let data = NSData(contentsOfFile: filePath) {
            do {
                let decoder = JSONDecoder()
                let productItems: [StoreItem] = try decoder.decode([StoreItem].self, from: data as Data)
                print(productItems.count)
                myitems = productItems
            }
            catch let err {
                //Handle error
                print(err)
            }
        }
        
        sectionHeaderSubtitleLabel.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        sectionHeaderSubtitleLabel.layer.borderWidth = 1
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath)
        if let productCell = cell as? StoreItemCell {
            productCell.setProductInfo(info: myitems[indexPath.row])
        }
        return cell
    }
}

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var subheadLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    
    var tagViews: [UILabel] = []
    
    func setProductInfo(info: StoreItem) {
        headLabel.text = info.title
        subheadLabel.text = info.description
        originalPriceLabel.text = "7,500"
        salePriceLabel.text = info.s_price
        
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
        mainImageView.layer.masksToBounds = true
        
        let fixedHeight: CGFloat = 22
        var labelX = headLabel.frame.origin.x
        let labelY = salePriceLabel.frame.origin.y + salePriceLabel.frame.height + 6.0
        let labelGap: CGFloat = 3.0
        let labelMargin: CGFloat = -2.0
        for deliveryType in info.delivery_type {
            let label = UILabel(frame: .zero)
            label.text = deliveryType
            label.backgroundColor = UIColor(red: 170.0/255.0, green: 116.0/255.0, blue: 191.0/255.0, alpha: 1.0)
            label.sizeToFit()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textColor = .white
            
            label.frame = CGRect(x: labelX, y: labelY,
                                 width: label.frame.width + labelMargin*2,
                                 height: fixedHeight)
            self.addSubview(label)
            
            labelX += label.frame.width + labelGap
        }
    }
}

struct StoreItem {
    let alt: String
    let delivery_type: [String]
    let description: String
    let detail_hash: String
    let image: String
    let s_price: String
    let title: String
}

extension StoreItem: Decodable {

}
