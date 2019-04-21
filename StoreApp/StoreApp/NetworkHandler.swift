//
//  NetworkHandler.swift
//  StoreApp
//
//  Created by 윤동민 on 18/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct NetworkHandler {
    static func getData(from urlType: ServerURL) {
        guard let url = URL(string: ServerURL.server + urlType.rawValue) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
       
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil else {
                NotificationCenter.default.post(name: .networkingError, object: nil)
                return
            }
            guard let parseData = JSONParser.parseJSONData(data) else {
                NotificationCenter.default.post(name: .parsingError, object: nil)
                return
            }
            switch urlType {
            case .main:
                NotificationCenter.default.post(name: .getMain, object: nil, userInfo: ["main": parseData.body])
            case .soup:
                NotificationCenter.default.post(name: .getSoup, object: nil, userInfo: ["soup": parseData.body])
            case .side:
                NotificationCenter.default.post(name: .getSide, object: nil, userInfo: ["side": parseData.body])
            }
        }
        dataTask.resume()
    }
}
