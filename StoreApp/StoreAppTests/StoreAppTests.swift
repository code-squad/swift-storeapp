//
//  StoreAppTests.swift
//  StoreAppTests
//
//  Created by yangpc on 2018. 1. 26..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import XCTest
@testable import StoreApp

class StoreAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func test_getJSONDataFromURL() {
        XCTAssertNotNil(DataManager.getJSONDataFromURL("main"))
    }

    func test_number() {
        let price = "6,750"
        let result: Int = 6750
        XCTAssertEqual(price.number, result)
    }

    func test_number_원() {
        let price = "6,750원"
        let result: Int = 6750
        XCTAssertEqual(price.number, result)
    }


    func test_decode() {
        let data = DataManager.getJSONDataFromURL("main")!
        XCTAssertNoThrow(try JSONDecoder().decode([StoreItem].self, from: data))
    }

}
