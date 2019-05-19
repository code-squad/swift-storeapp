//
//  Extensions.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

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
    static let storeItemsWillUpdate = NSNotification.Name("storeItemsDidUpdate")
    static let rowWillReload = NSNotification.Name("rowWillReload")
    static let imageDidDownload = NSNotification.Name("imageDidDownload")
}

extension JSONSerialization {
    static func body(with data: Data, name: String) -> Data? {
        guard let json = try? self.jsonObject(with: data, options: []) as? [String: Any],
            let data = try? self.data(withJSONObject: json[name], options: []) else { return nil }
        return data
    }
}
