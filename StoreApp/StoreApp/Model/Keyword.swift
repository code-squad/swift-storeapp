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
    case refreshImage
}

enum OrderKeyword: String {
    case url = "https://hooks.slack.com/services/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"
    case httpPostRequest = "POST"
    case dataType = "application/json"
    case headerField = "Content-Type"
}

enum SystemColor {
    enum StatusBar: String {
        case Blue = "iOSSystemBlue"
        case Pink = "iOSSystemPink"
        case Teal = "iOSSystemTeal"
        case Yellow = "iOSSystemYellow"
        case Orange = "iOSSystemOrange"
    }

    enum Label: String {
        case LightPurple = "LabelLightPurple"
        case Yellow = "LabelYellow"
    }
}

enum DiscountBadge: String {
    case Launching = "론칭특가"
    case Event = "이벤트특가"
}

enum DeliveryBadge: String {
    case Dawn = "새벽배송"
    case Nation = "전국택배"
}

enum ProgramDescription: String {
    case UnreachableNetworkInKorean = "네트워크에 연결할 수 없습니다 :(\n잠시 후에 다시 시도해주세요."
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
