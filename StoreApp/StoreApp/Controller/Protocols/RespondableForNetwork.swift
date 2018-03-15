//
//  RespondableForNetwork.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 15..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol RespondableForNetwork {
    func drawBorder(on view: UIView, when isNetworkAvailable: Bool)
}

extension RespondableForNetwork {
    func drawBorder(on view: UIView, when isNetworkAvailable: Bool) {
        let color: UIColor = (isNetworkAvailable) ? .green : .red
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 5
    }
}
