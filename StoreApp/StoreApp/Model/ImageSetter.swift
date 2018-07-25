//
//  ImageSetter.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 25..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class ImageSetter {

    class func download(with url: String, handler: @escaping((String) -> Void)) {
        URLSession.shared.downloadTask(with: URL(string: url)!) { (tmpLocation, response, error) in
            if let error = error {
                print("Image download Error log: \(error)\n")
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let tmpLocation = tmpLocation {
                handler(tmpLocation.path)
            }
        }.resume()
    }
}
