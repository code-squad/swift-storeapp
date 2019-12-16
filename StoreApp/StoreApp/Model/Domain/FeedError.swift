//
//  FeedError.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/16.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

enum FeedError: Error {
    case unknown
    case missingAsset(assetName: String)
    case decodingFailed(error: Error)
    
    var message: String {
        switch self {
        case .unknown: return "Unknown error"
        case let .missingAsset(assetName): return "Asset \(assetName) was nil"
        case let .decodingFailed(error): return "Decoding Failed: \(error.localizedDescription)"
        }
    }
}
