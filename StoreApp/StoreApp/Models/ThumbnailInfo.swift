//
//  ThumbnailInfo.swift
//  StoreApp
//
//  Created by yuaming on 17/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

class ThumbnailInfo {
  private(set) var image: UIImage?
  
  init(_ imageUrl: String?) throws {
    self.loadImage(imageUrl)
  }
  
  fileprivate func loadImage(_ urlString: String?) {
    guard let urlString = urlString,
      let url = API.shared.urlWithFullPath(urlString) else { return }
    
    API.shared.request(withUrl: url) { resultType in
      switch resultType {
      case .success(let data):
        if let data = data {
          self.image = UIImage(data: data)
        }
      case .error(let error):
        print(error.localizedDescription)
      }
    }
  }
}
