//
//  Queue.swift
//  StoreApp
//
//  Created by 윤동민 on 22/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct CustomQueue {
    static let queue = DispatchQueue.init(label: "itemUpdate")
}
