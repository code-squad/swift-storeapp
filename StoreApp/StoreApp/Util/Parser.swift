//
//  Parser.swift
//  StoreApp
//
//  Created by oingbong on 07/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Parser {
    static func json(fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: Key.jsonType) else { return nil }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            return jsonData
        } catch {
            return nil
        }
    }
    
    static func jsonUrl(fileName: String, handler: @escaping ([StoreItem]?) -> Void) {
        let urlString = Key.url + fileName
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            guard let reponseData = data else { return }
            let items = storeItems(from: reponseData)
            handler(items)
        }
        task.resume()
    }
    
    static func storeItems(from data: Data) -> [StoreItem]? {
        do {
            let items = try JSONDecoder().decode([StoreItem].self, from: data)
            return items
        } catch {
            return nil
        }
        
    }
}
