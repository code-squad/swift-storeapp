//
//  StoreItemDetail.swift
//  StoreApp
//
//  Created by yuaming on 17/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct StoreDetailItem: Decodable {
  var title: String?
  var detailHash: String
  var detailData: ItemDetailData?
  
  init(_ title: String, _ detailHash: String) {
    self.title = title
    self.detailHash = detailHash
  }
  
  enum CodingKeys: String, CodingKey {
    case detailHash = "hash"
    case detailData = "data"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.detailHash = try values.decode(String.self, forKey: .detailHash)
    self.detailData = try values.decode(ItemDetailData.self, forKey: .detailData)
  }
}

extension StoreDetailItem {
  func generateFileData() {
    let data = FileLoader.data(fileName: "HBDEF", fileType: FileTypes.json)
    load(data)
  }
  
  func requestData() {
    let url = API.shared.makeUrlInDetail(hash: detailHash)

    API.shared.sendRequest(withUrl: url) { resultType in
      DispatchQueue.main.async {
        switch resultType {
        case .success(let data):
          self.load(data)
        case .error(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  fileprivate func load(_ data: Data?) {
    if let data = data {
      let decodedData = JSONConverter.decode(in: data, type: StoreDetailItem.self)
      NotificationCenter.default.post(name: .detailData, object: nil, userInfo: [Constants.detailTitle: title, Constants.detailData: decodedData?.detailData])
    }
  }
}

extension Notification.Name {
  static let detailData = Notification.Name(Constants.detailData)
}
