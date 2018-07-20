//
//  API.swift
//  StoreApp
//
//  Created by yuaming on 13/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum API {
  static let shared: APIClient = DefaultAPI()
  case list(String)
  case getImage(String)
  case detail(String)
}

extension API {
  var path: String {
    switch self {
    case let .list(id):
      return "/\(id)"
    case let .getImage(imagePath):
      return "\(imagePath)"
    case let .detail(hash):
      return "/detail/\(hash)"
    }
  }
}

enum ResponseResult {
  case success(Data?)
  case error(Error)
}

protocol APIClient {
  func makeUrlInList(id: String) -> URL?
  func makeUrl(_ urlString: String) -> URL?
  func makeUrlInDetail(hash: String) -> URL?
}

extension APIClient {
  typealias ResultClosure = (ResponseResult) -> Void
  
  func sendRequest(withUrl url: URL?, completionHandler: @escaping ResultClosure) {
    guard let url = url else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completionHandler(.error(error))
      } else {
        completionHandler(.success(data))
      }
    }.resume()
  }
  
  func post(withUrl url: URL?, data: Data) {
    guard let url = url else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = data
    URLSession.shared.dataTask(with: request).resume()
  }
}

class DefaultAPI: APIClient {
  fileprivate let host = Host.base.path
  
  func makeUrlInList(id: String) -> URL? {
    return URL(string: "\(host)\(API.list(id).path)")
  }
  
  func makeUrl(_ urlString: String) -> URL? {
    return URL(string: "\(urlString)")
  }
  
  func makeUrlInDetail(hash: String) -> URL? {
    return URL(string: "\(host)\(API.detail(hash).path)")
  }
}

enum Host {
  case base
  case order
  case apple
}

extension Host {
  var path: String {
    switch self {
    case .base:
      return "http://crong.codesquad.kr:8080/woowa"
    case .order:
      return "https://hooks.slack.com/services/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"
    case .apple:
      return "https://www.apple.com"
    }
  }
}
