//
//  DetailView.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 6. 3..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

protocol DetailView: AnyObject {
    func show(with detailInfo: DetailInfo)
}
