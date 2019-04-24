//
//  StoreItemDetailMaker.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 17..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import os.log

class StoreItemDetailMaker {
    /// 슬랙 incoming hook URL
    private let slackHookURL = "https://hooks.slack.com/services/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"
    
    /// json 배열을 받아서 스토어아이템 배열로 리턴
    func makeStoreItemDetailModel(anyData: Data) -> StoreItemDetailModel? {
        // data 를 JSON 으로 변환
        guard let data = StoreItemMaker.jsonSerialization(jsonData: anyData) else {
            return nil
        }
        
        // json data 를 사전형으로 변환
        guard let checkedJSONData = data as? [String : Any] else {
             os_log("jsondata 에서 디테일모델용 data 생성 실패")
            return nil
        }
        
        // data 를 키로 문자열배열 추출
        guard let jsonData = checkedJSONData["data"] as? [String : Any] else {
            os_log("jsondata 에서 디테일모델용 data 생성 실패")
            return nil
        }
        
        // 디테일 모델 생성
        let detailModel = StoreItemDetailModel()
        
        let result = detailModel.setting(json: jsonData)
        
        guard result == true else {
             os_log("스토어아이템 디테일모델 생성 실패")
            return nil
        }
        
        //결과리턴
        return detailModel
    }
    /// 주문결과를 받아서 JSON data 로 리턴한다
    func makeJSONFrom(orderResult: OrderResult) -> Data? {
        
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
    func order(orderResult: OrderResult){
        // 주문결과를 받아서 JSON 화 한다
        guard let orderResultJSON = makeJSONFrom(orderResult: orderResult) else { return }
        
        guard let orderResultDescription = String(data: orderResultJSON, encoding: .utf8) else { return }
        
        let uncheckedURL = self.slackHookURL
        
        // url 을 작성한다
        guard let url = URL(string: uncheckedURL ) else { return () }
        
        // 리퀘스트 선언
        var request = URLRequest(url: url)
        
        // 방식은 POST
        request.httpMethod = "POST"
        
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

class OrderResult: Codable {
    /// 주문결과 텍스트
    let text : String
    
    init(customerName: String, price: String, menu: String){
        self.text = "\(customerName) 님이 \(price)원 짜리 \(menu) 를 구입하셨습니다."
    }
}
