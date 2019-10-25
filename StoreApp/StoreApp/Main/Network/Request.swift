//
//  Request.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/25.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit


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
        }
    }
    dataTask.resume()
}
