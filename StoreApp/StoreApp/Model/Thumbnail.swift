//
//  Thumbnail.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class Thumbnail: AsyncPresentable {
    weak var delegate: PresentImageDelegate?
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            delegate?.present(self, image: image)
        }
    }

    init(urlString: String) throws {
        loadImage(from: urlString)
    }
}
