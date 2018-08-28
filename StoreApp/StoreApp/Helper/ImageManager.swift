//
//  ImageManager.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 24..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation
import Alamofire

struct ImageManager {
    
    fileprivate static var cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    
    static func downloadThumbnailImage(_ url: String, _ completionHandler: @escaping (Data?) -> Void) {
        guard let imageURL = URL(string: url) else { return }
        let fileURL = cacheURL.appendingPathComponent(imageURL.lastPathComponent)
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in return (fileURL, []) }
        Alamofire.download(imageURL, to: destination).responseData { response in
            guard let loaded = response.value else {
                guard let localData = try? Data(contentsOf: fileURL) else { return }
                completionHandler(localData)
                return
            }
            completionHandler(loaded)
        }
    }
}
