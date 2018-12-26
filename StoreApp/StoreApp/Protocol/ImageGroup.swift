//
//  ImageGroup.swift
//  StoreApp
//
//  Created by oingbong on 26/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol ImageGroup {
    func configure(with item: DetailItem)
    func addImages(with fileName: String)
    func downloadImages(with imageURL: String)
}
