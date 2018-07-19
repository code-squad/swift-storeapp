//
//  Thumbnail.swift
//  StoreApp
//
//  Created by yuaming on 17/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

class Thumbnail {
  var image: UIImage?
  
  init(_ imageUrl: String?) {
    loadImageData(imageUrl)
  }
}

extension Thumbnail: ImageLoaderable { }


