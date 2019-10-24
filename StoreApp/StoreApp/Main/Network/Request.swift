//
//  Request.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/25.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit

func request(text: String) -> UIImage? {
    guard let url = URL(string: text),
    let data = try? Data(contentsOf: url) else { return UIImage() }
    let cellImage = UIImage(data: data)
    return cellImage
}
