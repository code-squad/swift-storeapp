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
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            return jsonData
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func jsonUrl(fileName: String, handler: @escaping ([StoreItem]?) -> Void) {
        guard let url = URL(string: "http://crong.codesquad.kr:8080/woowa/\(fileName)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
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
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
