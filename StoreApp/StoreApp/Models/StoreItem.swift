//
//  StoreItem.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    let detail_hash: String
    let image: String
    let alt: String
    let delivery_type: [String]
    let title: String
    let description: String
    let n_price: String?
    let s_price: String
    let badge: [String]?
}

extension String {
    func lastPathComponent() -> String {
        return NSString(string: self).lastPathComponent
    }
}

extension URL {
    static func cachesDirectory() -> URL? {
        let cacheURL = try? FileManager.default.url(for: .cachesDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: false)
        return cacheURL
    }
}

extension NSNotification.Name {
    static let imageDidDownload = NSNotification.Name("imageDidDownload")
}
