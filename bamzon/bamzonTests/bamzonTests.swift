//
//  bamzonTests.swift
//  bamzonTests
//
//  Created by Kellie Banzon on 01/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//
import XCTest
@testable import bamzon

class BamzonTests: XCTestCase {
    
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
    
    func testCreateIDFromString() {
        let testIDString = "u100" //fixme changed from IDType.user to string for demo
        let expected = ID(type: "u", uuid: "100")
        let testOut = IDUtility.generateIDFromString(idString: testIDString)
        print(testOut.uuid)
        print(testOut.type)
        
        XCTAssertTrue(expected.type == testOut.type)
        XCTAssertTrue(expected.uuid == testOut.uuid)
        
    }
    
    func testIDToString() {
        let expected = "u100"
        let testID = ID(type: "u", uuid: "100")
        let testOut = testID.toString()
        
        XCTAssertTrue(expected.elementsEqual(testOut))
        
    }
    
    func testIDsToStrings() {
        let expected  = ["u100", "t200"]
        let testIDs = [ID(type: "u", uuid: "100"), ID(type: "t", uuid: "200")]
        let testOut = IDUtility.idsToStrings(ids: testIDs)
        
        XCTAssertEqual(expected, testOut)
    }
    
    func testStringsToIDs() {
        let testStrings  = ["u100", "t200"]
        let expected = [ID(type: "u", uuid: "100"), ID(type: "t", uuid: "200")]
        let testOut = IDUtility.stringsToIDs(strs: testStrings)
        
        XCTAssertEqual(expected, testOut)
    }
    
    func testIntegrationLogin() {
        let login = LoginVC()
        let emailField = UITextField()
        emailField.text = "test@gmail.com"
        let pwField = UITextField()
        pwField.text = "password"

        login.email = emailField
        login.password = pwField

        let dispatch = DispatchGroup()
        dispatch.enter()
        login.loginVM.loadEmailVerified(dispatch: dispatch)
        
        dispatch.notify(queue: DispatchQueue.main) {
            XCTAssertTrue(login.loginVM.isEmailVerified)
        }
    }
}
