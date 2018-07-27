//
//  StoreAppUnitTests.swift
//  StoreAppUnitTests
//
//  Created by YOUTH2 on 2018. 7. 20..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import XCTest

class StoreAppUnitTests: XCTestCase {
    func testHash() {
        let expect = expectation(description: "Download should succeed")
        HashDataSetter.set(hashdata: RawHashData(code: "H9881")) { (data, response, error) in
            XCTAssertNil(error, "에러 발생: \(error)")
            XCTAssertNotNil(data, "에러 url")
            expect.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "테스트 타임 아웃 \(error)")
        }

    }


}
