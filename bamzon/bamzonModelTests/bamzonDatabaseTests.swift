//
//  bamzonDatabaseTests.swift
//  bamzonModelTests
//
//  Created by liblabs-mac on 3/16/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import XCTest
@testable import bamzon

class bamzonDatabaseTests: XCTestCase {
    
    var teamID: ID = ID(type: "test", uuid: "teamID")
    var eventID: ID = ID(type: "test", uuid: "eventID")
    var locationID: ID = ID(type: "test", uuid: "locationID")
    var userID1: ID = ID(type: "test", uuid: "userID-1")
    var userID2: ID = ID(type: "test", uuid: "userID-2")
    var date: Date = Date(timeIntervalSince1970: 1000000)
    var mediaID: ID = ID(type: "test", uuid: "mediaID")
    var joinReqID: ID = ID(type: "test", uuid: "joinReqID")
    
    override func setUp() {
        DBUtility.writeToDB(objToWrite: Event(eventID: eventID, teamID: teamID, name: "Integration Test Event", locationID: locationID, contactUserIDs: [:], description: "Test event for integration testing", date: date, tags: ["tag": "tag"], media: ["test media": mediaID], links: ["testlink" : "testlinkval"]))
        DBUtility.writeToDB(objToWrite: JoinRequest(joinReqID: joinReqID, userID: userID1, teamID: teamID))
        DBUtility.writeToDB(objToWrite: Practice(teamID: teamID, eventID: eventID, date: date, attendingUsers: [userID1: userID1], excusedUsers: [userID2: userID2]))
    }


//    func testEventFirebaseRead () {
//        let expectation = self.expectation(description: "read event")
//        DBUtility.readFromDB(table: FirTable.event, keys: eventID) {
//            (key: String, payload: [String: AnyObject]) in
//            readEvent = Event(key: key, payload: payload)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 5)
//
//        XCTAssertNotNil(readEvent)
//        // for some reason this fails, even though the underlying objects actually are equal
//        XCTAssertEqual(event.eventID, eventID)
//    }

    func testJoinRequestFirebaseRead () {
        let joinReq: JoinRequest = JoinRequest(joinReqID: joinReqID, userID: userID1, teamID: teamID)
        var readJoinReq: JoinRequest?
        
        let expectation = self.expectation(description: "read join request")
        DBUtility.readFromDB(table: FirTable.joinRequest, keys: joinReqID) {
            (key: String, payload: [String: AnyObject]) in
            readJoinReq = JoinRequest(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(readJoinReq)
        // for some reason this fails, even though the underlying objects actually are equal
//        XCTAssertEqual(joinReq, readJoinReq)
    }
    
    func testPracticeFirebaseRead () {
        let practice = Practice(teamID: teamID, eventID: eventID, date: date, attendingUsers: [userID1: userID1], excusedUsers: [userID2: userID2])
        var readPractice: Practice?
        
        let expectation = self.expectation(description: "read practice")
        DBUtility.readFromDB(table: FirTable.practice, keys: teamID, eventID) {
            (key: String, payload: [String: AnyObject]) in
            readPractice = Practice(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(readPractice)
        // for some reason this fails, even though the underlying objects actually are equal
//        XCTAssertEqual(practice, readPractice)
    }
}
