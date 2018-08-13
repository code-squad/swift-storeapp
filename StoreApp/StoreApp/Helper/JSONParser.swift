//
//  JSONParser.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

struct JSONParser {
    static private let decoder = JSONDecoder()
    
    static func parseFromAsset<T: Decodable>(fileName: String, dataType: T.Type) -> T? {
        guard let asset = NSDataAsset(name: fileName) else { return nil }
        guard let decoded = try? decoder.decode(dataType, from: asset.data) else { return nil }
        return decoded
    }
}
