//
//  NSMutableAttributedString+.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    
    var beauty: BeautyStringDSL {
        return BeautyStringDSL(self)
    }
}
