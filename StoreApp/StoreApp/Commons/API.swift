//
//  API.swift
//  StoreApp
//
//  Created by yuaming on 13/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum API {
  static let shared: APIServer = DefaultAPIServer()
  case list(String)
  case getImage(String)
}

extension API {
  var path: String {
    switch self {
    case let .list(id):
      return "/\(id)"
    case let .getImage(imagePath):
      return "\(imagePath)"
    }
  }
}

enum APIServerResult {
  case success(Data?)
  case error(Error)
}

protocol APIServer {
  func url(_ id: String) -> URL?
  func urlWithFullPath(_ fullPath: String) -> URL?
}

extension APIServer {
  typealias ResultClosure = (APIServerResult) -> Void
  
  func request(withUrl url: URL?, completionHandler: @escaping ResultClosure) {
    guard let url = url else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completionHandler(.error(error))
      } else {
        completionHandler(.success(data))
      }
    }.resume()
  }
}

private struct DefaultAPIServer: APIServer {
  let host: String = "http://crong.codesquad.kr:8080/woowa"
  
  func url(_ id: String) -> URL? {
    return URL(string: "\(host)\(API.list(id).path)")
  }
  
  func urlWithFullPath(_ fullPath: String) -> URL? {
    return URL(string: "\(fullPath)")
  }
}
