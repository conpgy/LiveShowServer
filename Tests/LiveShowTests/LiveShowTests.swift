//
//  LiveTests.swift
//  LiveTests
//
//  Created by penggenyong on 2016/12/22.
//
//

import XCTest
import MiniPromiseKit

@testable import LiveShow

class LiveShowTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_insertAnchor() {
        
        let e = expectation(description: "anchor inserted")
        
        let database = Database()

        var anchor = Anchor()
        anchor.uid = 1
        anchor.roomId = 1
        anchor.type = 0
        anchor.name = "one is all"
        anchor.isLive = false
        anchor.focus = 200
        anchor.pic51 = "onejiall.com"
        anchor.pic74 = "alljione.com"
        anchor.push = 1
        
        
        firstly {
            database.insert(with: anchor)
            }.then { result in
                e.fulfill()
            }.catch { error in
                XCTFail()
        }
        
        waitForExpectations(timeout: 10) { error in }
        
    }
    
    static var allTests: [(String, (LiveShowTests) -> () throws -> Void)] {
        return [
            ("test_insertAnchor", test_insertAnchor)
        ]
    }
    
}
