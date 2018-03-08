//
//  PresentImageDelegate.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 8..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol PresentImageDelegate: class {
    func present(_ contentType: AsyncPresentable, image: UIImage)
}
