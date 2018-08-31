//
//  StoreAPI.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 18..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct StoreAPI {
    private static let baseURL = "http://crong.codesquad.kr"
    private static let portNumber = 8080
    private static let path = "/woowa"
    private static let successCode = 200
    private static let hookInfoPlistName = "HookInfo"
    
    static func makeURL(from lastComponent: String) -> URL? {
        guard var components = URLComponents(string: baseURL) else { return nil }
        components.port = portNumber
        components.path = self.path
        components.path += "/\(lastComponent)"
        return components.url
    }
    
    static func fetchStoreItems(_ foodCategory: FoodCategory, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let url = self.makeURL(from: foodCategory.rawValue) else { return }
        let configure = URLSessionConfiguration.default
        configure.timeoutIntervalForRequest = 3
        
        let session = URLSession(configuration: configure)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == successCode else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        task.resume()
    }
    
    static func downloadThumbnailImage(imageURL: URL, session: URLSession, _ completionHandler: @escaping (URL?, Error?) -> Void) {
        let request = URLRequest(url: imageURL)
        session.downloadTask(with: request) { (tempURL, response, error) in
            guard let tempURL = tempURL else {
                completionHandler(nil, error)
                return
            }
            completionHandler(tempURL, nil)
        }.resume()
    }
    
    static func postHook(who: String, price: String, menu: String) {
        guard let hookInfo = makeHookInfo() else { return }
        guard var request = makeRequest(from: hookInfo) else { return }
        let parameters = ["text": "\(who)이 \(menu)를 주문했습니다. 가격: \(price)"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request).resume()
    }
    
    private static func makeRequest(from hookInfo: HookInfo) -> URLRequest? {
        guard let url = URL(string: hookInfo.hookURL) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = hookInfo.httpMethod
        request.addValue(hookInfo.headerValue, forHTTPHeaderField: hookInfo.httpHeaderField)
        return request
    }
    
    private static func makeHookInfo() -> HookInfo? {
        guard let path = Bundle.main.path(forResource: hookInfoPlistName, ofType: "plist") else { return nil }
        let plistURL = URL(fileURLWithPath: path)
        guard let plistData = try? Data(contentsOf: plistURL) else { return nil }
        return decodeHookInfoData(plistData)
    }
    
    private static func decodeHookInfoData(_ data: Data) -> HookInfo? {
        let decoder = PropertyListDecoder()
        guard let hookInfo = try? decoder.decode(HookInfo.self, from: data) else { return nil }
        return hookInfo
    }
}

struct HookInfo: Decodable {
    var hookURL: String
    var httpMethod: String
    var headerValue: String
    var httpHeaderField: String
    
    enum CodingKeys: String, CodingKey {
        case hookURL
        case httpMethod
        case headerValue
        case httpHeaderField
    }
}
