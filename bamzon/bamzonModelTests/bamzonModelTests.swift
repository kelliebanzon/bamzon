//
//  bamzonModelTests.swift
//  bamzonModelTests
//
//  Created by Daniel Heyde on 2/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import XCTest
@testable import bamzon

class bamzonModelTests: XCTestCase {

//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    // TEST
    // init
    // formatForDB
    // getTable
    // getChildPath
    
    func testEventDBCreate() {
        let expected = Event(eventID: ID(type: "e", num: 999), teamID: ID(type: "t", num: 999), name: "test event", location: nil, contactUserIDs: [ID(type: "u", num: 999)], description: "test event description", date: "2019", rsvps: nil, tags: ["test"], media: [:], links: [:])
        
        let key = "e999"
        let payload = ["contactUserIds": ["u999"],
                       "date": "2019",
                       "name": "test event",
                       "tags": ["test"],
                       "location": nil,
                       "teamId": "t999",
                       "description": "test event description"] as [String : AnyObject]
        
        XCTAssertEqual(Event(key: key, payload: payload), expected)
    }

}
