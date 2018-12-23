//
//  Parser.swift
//  StoreApp
//
//  Created by oingbong on 07/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation
import UIKit

struct Parser {
    static func decode<T: Decodable>(from data: Data) -> T? {
        do {
            let items = try JSONDecoder().decode(T.self, from: data)
            return items
        } catch {
            return nil
        }
    }
}
