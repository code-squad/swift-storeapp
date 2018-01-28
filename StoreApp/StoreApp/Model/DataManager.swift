//
//  DataManager.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 28..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import Foundation

struct DataManager {
    static func getJSONDataFromURL(_ resource:String) -> Data? {
        guard let filePath = Bundle.main.path(forResource: resource, ofType: "json") else {
            return nil
        }
        let url = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: url, options: .uncached)
            return data
        } catch let error{
            print(error)
        }
        return nil
    }
}
