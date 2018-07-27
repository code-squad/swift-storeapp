//
//  DetailHash.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 27..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class DetailHash: URLDataProtocol {
    let baseURL = URL(string: "http://crong.codesquad.kr:8080/woowa/detail/")!
    var url: URL

    init(hashCode: String) {
        self.url = baseURL.appendingPathComponent(hashCode)
    }
}
