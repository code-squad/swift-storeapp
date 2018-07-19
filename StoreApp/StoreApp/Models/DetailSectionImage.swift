//
//  DetailSectionImage.swift
//  StoreApp
//
//  Created by yuaming on 18/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

class DetailSectionImage {
  fileprivate(set) var image: UIImage?
  
  init(_ imageUrl: String?) {
    loadImageData(imageUrl)
  }
  
  func loadImageData(_ urlString: String?) {
    guard let urlString = urlString else { return }
    
    let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    dispatchQueue.async {
      if let cachedData = ImageCache.fetchData(urlString) {
        self.image = UIImage(data: cachedData)
      } else {
        self.requestImageData(urlString)
      }
    }
  }
  
  func requestImageData(_ urlString: String) {
    guard let url = API.shared.makeUrl(urlString) else { return }
    
    API.shared.sendRequest(withUrl: url) { resultType in
      switch resultType {
      case .success(let data):
        guard let data = data else { return }
        ImageCache.store(urlString, content: data)
        self.image = UIImage(data: data)
      case .error(let error):
        print(error.localizedDescription)
      }
    }
  }
}
