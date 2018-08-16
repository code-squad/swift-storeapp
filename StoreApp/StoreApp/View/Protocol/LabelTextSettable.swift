//
//  HeaderViewLabelTextSetter.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

protocol LabelTextSettable {
    var title: String { get }
    var description: String { get }
}

protocol StoreItemLabelTextSettable: LabelTextSettable {
    var normalPrice: String? { get }
    var salePrice: String { get }
    var badges: [String]? { get }
}
