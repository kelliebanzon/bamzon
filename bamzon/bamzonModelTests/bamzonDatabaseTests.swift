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
    var orgID: ID = ID(type: "test", uuid: "organizationID")
    var teamID2: ID = ID(type: "test", uuid: "idkman")
    
    override func setUp() {
        DBUtility.writeToDB(objToWrite: Event(eventID: eventID, teamID: teamID, name: "Integration Test Event", locationID: locationID, contactUserIDs: [:], description: "Test event for integration testing", date: date, tags: ["tag": "tag"], media: ["test media": mediaID], links: ["testlink" : "testlinkval"]))
        DBUtility.writeToDB(objToWrite: JoinRequest(joinReqID: joinReqID, userID: userID1, teamID: teamID))
        DBUtility.writeToDB(objToWrite: Practice(teamID: teamID, eventID: eventID, date: date, attendingUsers: [userID1: userID1], excusedUsers: [userID2: userID2]))
        DBUtility.writeToDB(objToWrite: Location(locID: locationID, name: "Test Location", number: "1", street: "Grand Ave", street2: nil, city: "Arroyo Grande", state: "CA", zip: 93410, country: nil))
        DBUtility.writeToDB(objToWrite: PlayerStats(userID: userID1, teamID: teamID, fields: ["test key" : "test value"]))
        DBUtility.writeToDB(objToWrite: Media(url: "testurl", mediaID: mediaID))
        DBUtility.writeToDB(objToWrite: Organization(orgID: orgID, name: "test organization", locationID: locationID, teamIDs: [teamID : teamID]))
        DBUtility.writeToDB(objToWrite: PlayerPerms(teamID: teamID, userID: userID1, permissions: [Permissions.editTeamInfo]))
        DBUtility.writeToDB(objToWrite: RSVP(eventID: eventID, yesUserIDs: [], noUserIDs: [userID1], pendingUserIDs: [userID2]))
        DBUtility.writeToDB(objToWrite: Team(teamID: teamID, orgID: orgID, userIDs: [userID1: userID1], teamName: "test team", sport: "integration testing", joinReqIDs: [userID2: userID2], blacklistUserIDs: [:]))
        DBUtility.writeToDB(objToWrite: TeamStats(teamID: teamID, memberCount: 69, wins: 4, losses: 2, ties: 0, fields: ["test stat": "test value"]))
        DBUtility.writeToDB(objToWrite: TeamCalendar(teamID: teamID, eventIDs: [eventID]))
        DBUtility.writeToDB(objToWrite: TeamCalendar(teamID: teamID2, eventIDs: []))
        DBUtility.writeToDB(objToWrite: User(userID: userID1, firstName: "Test", lastName: "User", nickname: "McTesterson", phone: nil, email: "tests@bamzon.kr", schoolYear: Year.alumni, bio: "For all those integration tests", imageURL: nil, teamIDs: [teamID: teamID]))
        DBUtility.writeToDB(objToWrite: PlayerAttendance(userID: userID1, teamID: teamID, presentPractices: [eventID]))
        sleep(2)
    }

    func testEventFirebaseRead () {
        let expectedEvents = Event(eventID: eventID, teamID: teamID, name: "Integration Test Event", locationID: locationID, contactUserIDs: [:], description: "Test event for integration testing", date: date, tags: ["tag": "tag"], media: ["test media": mediaID], links: ["testlink" : "testlinkval"])
        var readEvent: Event?

        let expectation = self.expectation(description: "read event")
        
        DBUtility.readFromDB(table: FirTable.event, keys: eventID) {
            (key: String, payload: [String: AnyObject]) in
            readEvent = Event(key: key, payload: payload)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)

        XCTAssertNotNil(readEvent)
    }
    
    func testJoinRequestFirebaseRead () {
        let expectedJoinReq: JoinRequest = JoinRequest(joinReqID: joinReqID, userID: userID1, teamID: teamID)
        var readJoinReq: JoinRequest?
        
        let expectation = self.expectation(description: "read join request")
        DBUtility.readFromDB(table: FirTable.joinRequest, keys: joinReqID) {
            (key: String, payload: [String: AnyObject]) in
            readJoinReq = JoinRequest(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(readJoinReq)
    }

    func testLocationFirebaseRead() {
        let expectedLocation = Location(locID: locationID, name: "Test Location", number: "1", street: "Grand Ave", street2: nil, city: "Arroyo Grande", state: "CA", zip: 93410, country: nil)
        var readLocation: Location?
        
        let expectation = self.expectation(description: "read location")
        DBUtility.readFromDB(table: FirTable.location, keys: locationID) {
            (key: String, payload: [String: AnyObject]) in
            readLocation = Location(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(readLocation)
    }
    
    func testMediaFirebaseRead () {
        let expectedMedia = Media(url: "testurl", mediaID: mediaID)
        var readMedia: Media?
        
        let expectation = self.expectation(description: "read media")
        DBUtility.readFromDB(table: FirTable.media, keys: mediaID) {
            (key: String, payload: [String: AnyObject]) in
            readMedia = Media(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(readMedia)
    }
    
    func testOrganizationFirebaseRead () {
        let expected = Organization(orgID: orgID, name: "test organization", locationID: locationID, teamIDs: [teamID : teamID])
        var read: Organization?
        
        let expectation = self.expectation(description: "read organization")
        DBUtility.readFromDB(table: FirTable.organization, keys: orgID) {
            (key: String, payload: [String: AnyObject]) in
            read = Organization(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
    func testPlayerPermsFirebaseRead () {
        let expected = PlayerPerms(teamID: teamID, userID: userID1, permissions: [Permissions.editTeamInfo])
        var read: PlayerPerms?
        
        let expectation = self.expectation(description: "read player perms")
        DBUtility.readFromDB(table: FirTable.playerPerms, keys: userID1, teamID) {
            (key: String, payload: [String: AnyObject]) in
            read = PlayerPerms(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
    func testPlayerStatsFirebaseRead() {
        let expectedPStats = PlayerStats(userID: userID1, teamID: teamID, fields: ["test key" : "test value"])
        var readPStats: PlayerStats?
        
        let expectation = self.expectation(description: "read player stats")
        DBUtility.readFromDB(table: FirTable.playerStats, keys: teamID, userID1) {
            (key: String, payload: [String: AnyObject]) in
            readPStats = PlayerStats(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(readPStats)
    }
    
    func testRSVPFirebaseRead () {
        let expected = RSVP(eventID: eventID, yesUserIDs: [], noUserIDs: [userID1], pendingUserIDs: [userID2])
        var read: RSVP?
        
        let expectation = self.expectation(description: "read rsvp")
        DBUtility.readFromDB(table: FirTable.rsvp, keys: eventID) {
            (key: String, payload: [String: AnyObject]) in
            read = RSVP(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
    func testTeamFirebaseRead () {
        let expected = Team(teamID: teamID, orgID: orgID, userIDs: [userID1: userID1], teamName: "test team", sport: "integration testing", joinReqIDs: [userID2: userID2], blacklistUserIDs: [:])
        var read: Team?
        
        let expectation = self.expectation(description: "read team")
        DBUtility.readFromDB(table: FirTable.team, keys: teamID) {
            (key: String, payload: [String: AnyObject]) in
            read = Team(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
    func testTeamCalendarFirebaseRead () {
        let expected = TeamCalendar(teamID: teamID, eventIDs: [eventID])
        var read: TeamCalendar?
        
        let expectation = self.expectation(description: "read teamCalendar")
        DBUtility.readFromDB(table: FirTable.teamCalendar, keys: teamID) {
            (key: String, payload: [String: AnyObject]) in
            read = TeamCalendar(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
    func testTeamCalendarFirebaseReadNoEvents () {
        let expected = TeamCalendar(teamID: teamID, eventIDs: []) // will contain sample user
        var read: TeamCalendar?
        
        let expectation = self.expectation(description: "read teamCalendar")
        DBUtility.readFromDB(table: FirTable.teamCalendar, keys: teamID2) {
            (key: String, payload: [String: AnyObject]) in
            read = TeamCalendar(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
    func testTeamStatsFirebaseRead () {
        let expected = TeamStats(teamID: teamID, memberCount: 69, wins: 4, losses: 2, ties: 0, fields: ["test stat": "test value"])
        var read: TeamStats?
        
        let expectation = self.expectation(description: "read teamstats")
        DBUtility.readFromDB(table: FirTable.team, keys: teamID) {
            (key: String, payload: [String: AnyObject]) in
            read = TeamStats(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
    func testUserFirebaseRead () {
        let expected = User(userID: userID1, firstName: "Test", lastName: "User", nickname: "McTesterson", phone: nil, email: "tests@bamzon.kr", schoolYear: Year.alumni, bio: "For all those integration tests", imageURL: nil, teamIDs: [teamID: teamID])
        var read: User?
        
        let expectation = self.expectation(description: "read user")
        DBUtility.readFromDB(table: FirTable.user, keys: userID1) {
            (key: String, payload: [String: AnyObject]) in
            read = User(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }

    func testPracticeFirebaseRead () {
        let expectedPractice = Practice(teamID: teamID, eventID: eventID, date: date, attendingUsers: [userID1: userID1], excusedUsers: [userID2: userID2])
        var readPractice: Practice?
        
        let expectation = self.expectation(description: "read practice")
        DBUtility.readFromDB(table: FirTable.practice, keys: teamID, eventID) {
            (key: String, payload: [String: AnyObject]) in
            readPractice = Practice(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(readPractice)
    }
    
    func testPlayerAttendanceFirebaseRead () {
        let expected = PlayerAttendance(userID: userID1, teamID: teamID, presentPractices: [eventID])
        var read: PlayerAttendance?
        
        let expectation = self.expectation(description: "read practice")
        DBUtility.readFromDB(table: FirTable.playerAttendance, keys: userID1, teamID) {
            (key: String, payload: [String: AnyObject]) in
            read = PlayerAttendance(key: key, payload: payload)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(read)
    }
    
}
