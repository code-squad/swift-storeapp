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
    static let slackUrl = "https://hooks.slack.com/services/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"
    
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
    
    static func imageDownLoad(with url: URL, handler: @escaping (String) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (location, _, error) in
            let destinaionURL = LocalFileManager.filePath(fileName: url.lastPathComponent)
            try? FileManager.default.removeItem(at: destinaionURL)
            do {
                try FileManager.default.moveItem(at: location!, to: destinaionURL)
            } catch {
                NotificationCenter.default.post(name: NotificationKey.error, object: nil)
            }
            
            handler(url.lastPathComponent)
        }
        task.resume()
    }
    
    static func slackUrl(with orderSheet: OrderSheet, handler: @escaping (Bool?) -> Void) {
        guard let customer = orderSheet.customer else { return }
        guard let price = orderSheet.price else { return }
        guard let menu = orderSheet.menu else { return }
        let message = "🤡 \(customer)님이 \(price)짜리 \(menu)를 주문하였습니다 🤡"
        let body = ["text": message]
        post(with: slackUrl, body: body) { (_) in
            handler(true)
        }
    }
    
    static private func post(with destinationUrl: String, body: Dictionary<String, String>, handler: @escaping (Bool?) -> Void) {
        guard let url = URL(string: destinationUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) else { return }
        request.httpBody = jsonBody
        let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if error != nil { return }
            handler(true)
        }
        task.resume()
    }
}
