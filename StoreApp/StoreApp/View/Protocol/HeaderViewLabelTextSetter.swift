//
//  HeaderViewLabelTextSetter.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

protocol HeaderViewLabelTextSetter {
    var title: String { get }
    var description: String { get }
}

protocol StoreItemCellLabelTextSetter: HeaderViewLabelTextSetter {
    var normalPrice: String? { get }
    var salePrice: String { get }
    var badges: [String]? { get }
}
