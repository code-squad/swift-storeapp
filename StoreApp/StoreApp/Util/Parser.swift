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
    static let jsonType = "json"
    static let woowaUrl = "http://crong.codesquad.kr:8080/woowa/"
    
    static func json(fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: jsonType) else { return nil }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            return jsonData
        } catch {
            return nil
        }
    }
    
    static func jsonUrl(fileName: String, handler: @escaping (Data?) -> Void) {
        let urlString = woowaUrl + fileName
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil { return }
            handler(data)
        }
        task.resume()
    }
    
    static func decode<T: Decodable>(from data: Data) -> T? {
        do {
            let items = try JSONDecoder().decode(T.self, from: data)
            return items
        } catch {
            return nil
        }
    }
    
    static func imageDownLoad(with url: URL, handler: @escaping (Bool) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (location, _, error) in
            let destinaionURL = LocalFileManager.filePath(fileName: url.lastPathComponent)
            try? FileManager.default.removeItem(at: destinaionURL)
            do {
                try FileManager.default.moveItem(at: location!, to: destinaionURL)
            } catch let error {
                print("Could not move file to disk : \(error.localizedDescription)")
            }
            handler(true)
        }
        
        task.resume()
    }
}
