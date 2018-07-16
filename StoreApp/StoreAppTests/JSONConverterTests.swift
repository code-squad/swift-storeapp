//
//  JSONConverterTests.swift
//  StoreAppTests
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import StoreApp

class JSONConverterTest: XCTestCase {
  func test_JSON_파일_읽기() {
    let data = FileLoader.data(file: .main, fileType: .json)
    XCTAssert(data!.isEmpty == false)
  }
  
  func test_JSON_Decode_확인() {
    let data = FileLoader.data(file: .main, fileType: .json)
    let item = JSONConverter.decode(in: data!, type: [StoreItem].self)
    XCTAssert(item.count >= 1)
  }
}
