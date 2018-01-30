//
//  Section.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 30..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import Foundation

enum Section: Int {
    case main, soup, side
    var title: String {
        switch self {
        case .main: return .mainTitle
        case .soup: return .soupTitle
        case .side: return .sideTitle }
    }
    var detail: String {
        switch self {
        case .main: return .mainDetail
        case .soup: return .soupDetail
        case .side: return .sideDetail }
    }
    static var numberOfSections: Int { return 3 }
}
