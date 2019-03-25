//
//  ViewController.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController {
    
    let json = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 물품 리스트 선언
        var storeItemList : [StoreItem] = []
        
        // json 파일 패스 찾기
        if let path = Bundle.main.path(forResource: "main", ofType: "json") {
            do {
                // 패스에서 데이터 추출
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                // 데이터 json 형태로 추출
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                // json 데이터를 배열로 추출
                if let jsonList = jsonResult as? Array<[String : Any]> {
                    // json 배열의 모든 객체를 추가시도
                    for json in jsonList {
                        // 배열화된 json 을 물품객체로 생성
                        guard let newItem = StoreItem(json: json) else {
                            // 에러시
                            os_log("json 1개 품목 파싱 실패 : %@",json["title"] as! CVarArg)
                            continue
                        }
                        // 생성된 물품을 배열에 추가
                        storeItemList.append(newItem)
                        os_log("json 파싱 성공 : %@",newItem.title)
                    }
                }
            } catch {
                // 에러시
                os_log("json 전체 파싱 실패")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

