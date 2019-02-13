//
//  bamzonTests.swift
//  bamzonTests
//
//  Created by Kellie Banzon on 01/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import XCTest
@testable import bamzon

class bamzonTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testCreateIDFromString(){
        let testIDString = "u100"
        let expected = ID(type: IdType.user, num: 100)
        let testOut = IDUtility.generateIDFromString(idString: testIDString)
        print(testOut.num)
        print(testOut.type)
        
        XCTAssertTrue(expected.type == testOut.type)
        XCTAssertTrue(expected.num == testOut.num)

    }
    
    func testIDToString(){
        let expected = "u100"
        let testID = ID(type: IdType.user, num: 100)
        let testOut = testID.getString()
        
        XCTAssertTrue(expected.elementsEqual(testOut))
        
    }
    
    func testCreateIDFromStringThrowsError(){
        let testIDString = "k100"
        let expected = ID(type: IdType.other, num: 100)
        let testOut = IDUtility.generateIDFromString(idString: testIDString)
        print(testOut.num)
        print(testOut.type)
        
        XCTAssertTrue(expected.type == testOut.type)
        XCTAssertTrue(expected.num == testOut.num)
        
    }

}
