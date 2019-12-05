//
//  Reusable.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

protocol Reusable {
    
    static var reuseId: String { get }
}

extension Reusable {
    
    static var reuseId: String {
        return String(describing: self)
    }
}
