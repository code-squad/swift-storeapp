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
    let jsonData = JSONConverter.data(fileName: "main", fileType: "json")
    XCTAssert(jsonData.count >= 1)
  }
}
