//
//  ServerURL.swift
//  StoreApp
//
//  Created by 윤동민 on 18/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

enum ServerURL: String, CaseIterable {
    static var server: String {
        return "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
    }
    case main = "main"
    case soup = "soup"
    case side = "side"
}
