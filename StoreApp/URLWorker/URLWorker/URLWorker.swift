//
//  URLWorker.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 4..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import os

class URLWorker {
    /// JSON data 받아서 스토어아이템 슬롯으로 변환, 데이터소스오브젝트에 넣는다
    class private func inputData(JSONData: Data, dataSourceObject: DataSourceObject, index: Int){
        // JSONData를 스토어아이템 배열로 치환
        let storeItemList = StoreItemMaker.makeStoreItemList(jsonData: JSONData)
        
        // 슬롯으로 생성
        let storeItemSlot = StoreItemSlot(storeItemList: storeItemList)
        
        // 데이터 입력부터 리로드 까지를 한덩이로 묶어서 DispatchQueue 에 넣는다
        DispatchQueue.main.async {
            // 생성된 객체를 데이터소스에 입력
            dataSourceObject.inputData(storeItemSlot: storeItemSlot, index: index)
            
            // 로깅을 위한 정수형 -> 문자형 변환
            let indexString : String = String(index)
            os_log("데이터소스에 슬롯추가완료. index : %@",indexString)
            
            // 데이터가 추가됬으니 해당 섹션만 리로드
            NotificationCenter.default.post(name: .didAddStoreItemSlot, object: index)
        }
    }
    
    /// url 을 받아서 데이터 리턴
    class private func dataFrom(unCheckedURL: String, dataSourceObject: DataSourceObject, index: Int){
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        guard let url = URL(string: "\(unCheckedURL)") else {
            os_log("잘못된 URL 입니다.")
            return
        }
        
        // Request
        let request = URLRequest(url: url)
        
        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            // getting Data Error
            guard error == nil else {
                os_log("url 접속실패")
                return
            }
            
            if let jsonData = data, let response = response as? HTTPURLResponse, response.statusCode == 200   {
                // 로깅을 위한 형변환
                let indexString = String(index)
                os_log("jsonData 데이터소스에 추가 시도, index : %@",indexString)
                
                // url 에서 데이터를 가져오는데 성공했으면 해당 데이터를 객체변환 하는 함수에 전달
                self.inputData(JSONData: jsonData, dataSourceObject: dataSourceObject, index: index)
                
                // 성공로그
                os_log("jsonData 데이터소스에 추가 성공, index : %@",indexString)
            }
        }
        dataTask.resume()
    }
    
    /// URL 배열을 받아서 Data 배열로 리턴
    class func makeDataListFrom(unCheckedURLList: [String], dataSourceObject: DataSourceObject) {
        // url 카운트 만큼 미리 빈 슬롯을 추가해준다
        for _ in 0..<unCheckedURLList.count {
            dataSourceObject.addEmptyStoreItemSlot()
        }
        
        for count in 0..<unCheckedURLList.count {
            // 데이터 추출 성공시 결과변수에 추가
            dataFrom(unCheckedURL: unCheckedURLList[count], dataSourceObject: dataSourceObject, index: count)
        }
    }
}
