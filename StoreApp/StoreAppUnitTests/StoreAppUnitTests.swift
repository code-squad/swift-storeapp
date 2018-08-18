//
//  StoreAppUnitTests.swift
//  StoreAppUnitTests
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

import XCTest

class StoreAppUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitStorItemListFrom_main_success() {
        let storeItemList = StoreItemList(.main)
        XCTAssertNotNil(storeItemList)
    }
    
    func testInitStoreItemListFrom_side_success() {
        let storeItemList = StoreItemList(.side)
        XCTAssertNotNil(storeItemList)
    }
    
    func testInitStoreItemListFrom_soup_success() {
        let storeItemList = StoreItemList(.soup)
        XCTAssertNotNil(storeItemList)
    }
    
    func testMakeStoreAPIURL_main_success() {
        let url = StoreAPI.storeURL(category: .main)
        XCTAssertEqual(URL(string: "http://crong.codesquad.kr:8080/woowa/main"), url)
    }
    
    func testMakeStoreAPIURL_side_success() {
        let url = StoreAPI.storeURL(category: .side)
        XCTAssertEqual(URL(string: "http://crong.codesquad.kr:8080/woowa/side"), url)
    }
    
    func testMakeStoreAPIURL_soup_success() {
        let url = StoreAPI.storeURL(category: .soup)
        XCTAssertEqual(URL(string: "http://crong.codesquad.kr:8080/woowa/soup"), url)
    }
}
