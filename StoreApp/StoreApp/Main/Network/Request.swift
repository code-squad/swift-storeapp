//
//  Request.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/25.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit

let decoder = JSONDecoder()
let didReceiveFoodNotification = Notification.Name("didReceiveFood")
let didReceiveImageNotification = Notification.Name("didReceiveImage")

func requestJson(text: String, completionHandler: @escaping (Foods) -> Void) {
    guard let url = URL(string: text) else { return }
    let request = URLRequest(url: url)
    let dataTask = URLSession(configuration: .default).dataTask(with: request) { (data, _, error) in
        if let error = error {
            print(error.localizedDescription)
        }
        if let data = data {
            guard let apiResponse = try? decoder.decode(Foods.self, from: data) else { return }
            DispatchQueue.main.async {
                completionHandler(apiResponse)
//                NotificationCenter.default.post(name: didReceiveFoodNotification,
//                                                object: nil,
//                                                userInfo: ["food": apiResponse])
            }
        }
    }
    dataTask.resume()
}

func requestURL(text: String, completion: @escaping (_: UIImage?) -> Void) {
    guard let url = URL(string: text) else { return }
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: url) { data, _, error in
        if let error = error {
            print(error.localizedDescription)
        }
        guard let data = data else { return }
        DispatchQueue.main.async {
            completion(UIImage(data: data))
            let image = UIImage(data: data)
//            NotificationCenter.default.post(name: didReceiveImageNotification,
//                                            object: nil,
//                                            userInfo: ["image": image])
        }
    }
    dataTask.resume()
}
