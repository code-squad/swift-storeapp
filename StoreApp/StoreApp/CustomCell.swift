//
//  ItemCell.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/23.
//  Copyright © 2019 hong3. All rights reserved.
//

import UIKit

//MARK: - CustomCell
class ItemCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelSprice: UILabel!
    @IBOutlet weak var labelNprice: UILabel!
    @IBOutlet weak var BadgeCollectionView: UICollectionView!
    var items: [StoreItem]!
    func config(model:StoreItem) {
        self.items = model
    }
}

extension ItemCell{

}

extension ItemCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("123123123")
        print("")
        
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        return UICollectionViewCell()
    }
}
