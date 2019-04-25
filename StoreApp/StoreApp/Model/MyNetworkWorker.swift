//
//  MyNetworkWorker.swift
//  StoreApp
//
//  Created by Yoda Codd on 25/04/2019.
//  Copyright © 2019 Drake. All rights reserved.
//

import Foundation
import os.log

class MyNetworkWorker {
    /// 슬랙 incoming hook URL
    static private let slackHookURL = "https://hooks.slack.com/services/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"
    
    /// 주문결과를 받아서 JSON data 로 리턴한다
    class private func makeJSONFrom(orderResult: OrderResult) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(orderResult)
            
            return data
        }
        catch {
            os_log("주문결과 JSON 변환 실패 : %@", orderResult.text)
            return nil
        }
    }
    
    
    /// 주문내역을 post 방식으로 보낸다
    class func post(orderResult: OrderResult){
        // 주문결과를 받아서 JSON 화 한다
        guard let orderResultJSON = makeJSONFrom(orderResult: orderResult) else { return }
        
        let uncheckedURL = self.slackHookURL
        
        // url 을 작성한다
        guard let url = URL(string: uncheckedURL ) else { return () }
        
        // 리퀘스트 선언
        var request = URLRequest(url: url)
        
        // 방식은 POST
        request.httpMethod = "POST"
        // 바디설정
        request.httpBody = orderResultJSON
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                os_log("error: %@", error as CVarArg)
            } else {
                if let response = response as? HTTPURLResponse {
                    os_log("statusCode: %@", String(response.statusCode))
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    os_log("data: %@", dataString)
                }
            }
        }
        task.resume()
    }
}
