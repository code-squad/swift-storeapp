//
//  Keyword.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 13..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

enum Keyword: String {
    case HeaderView
    case headerView
    case itemCell
    case customHeader
    case sectionPath
}

enum DiscountBadge: String {
    case Launching = "론칭특가"
    case Event = "이벤트특가"
}

enum DeliveryBadge: String {
    case Dawn = "새벽배송"
    case Nation = "전국택배"
}

extension String {
    func discountBadge() -> DiscountBadge? {
        switch self {
        case "론칭특가" : return .Launching
        case "이벤트특가" : return .Event
        default : return nil
        }
    }

    func deliveryBadge() -> DeliveryBadge? {
        switch self {
        case "새벽배송": return .Dawn
        case "전국택배": return .Nation
        default : return nil
        }
    }
}
