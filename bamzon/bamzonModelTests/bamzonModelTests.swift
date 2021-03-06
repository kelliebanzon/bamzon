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
    let uID999 = ID(type: "u", uuid: "999")
    let tID999 = ID(type: "t", uuid: "999")
    
    func testEventDBCreate() {
        let expected = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "test event", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: Date.init(timeIntervalSince1970: 3600), tags: ["test": "test"], media: [:], links: [:])
        
        let key = "e999"
        let payload = ["contactUserIDs": ["u999":"u999"],
                       "date": "1970-01-01 01:00 -0000",
                       "name": "test event",
                       "tags": ["test": "test"],
                       "location": "z0",
                       "teamID": "t999",
                       "description": "test event description"] as [String : AnyObject]
        
        XCTAssertEqual(Event(key: key, payload: payload), expected)
    }
    
    func testEventDBFuncs() {
        let evnt = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "test event", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: Date.init(timeIntervalSince1970: 10), tags: ["test": "test"], media: [:], links: [:])
        
        XCTAssertEqual(evnt.getTable(), FirTable.event)
        XCTAssertEqual(evnt.getChildPath(), "e999")
    }
    
    func testPlayerStatsDBCreate() {
        let expected = PlayerStats(userID: uID999, teamID: tID999, fields: ["best": "test"])
        
        let key = "u999"
        let payload = ["fields": ["best": "test"],
                       "teamID": "t999"] as [String: AnyObject]
        
        XCTAssertEqual(PlayerStats(key: key, payload: payload), expected)
    }
    
    func testPlayerStatsDBFuncs() {
        let pstat = PlayerStats(userID: uID999, teamID: tID999, fields: ["best": "test"])
        
        XCTAssertEqual(pstat.getTable(), FirTable.playerStats)
        XCTAssertEqual(pstat.getChildPath(), "t999/u999")
    }
    
    func testJoinRequestDBCreate() {
        let expected = JoinRequest(joinReqID: ID(type: "j", uuid: "999"), userID: uID999, teamID: tID999)
        
        let key = "j999"
        let payload = ["userID": "u999",
                       "teamID": "t999"] as [String: AnyObject]
        
        XCTAssertEqual(expected, JoinRequest(key: key, payload: payload))
    }
    
    func testJoinRequestDBFuncs() {
        let jReq = JoinRequest(joinReqID: ID(type: "j", uuid: "999"), userID: uID999, teamID: tID999)
        
        XCTAssertEqual(jReq.getTable(), FirTable.joinRequest)
        XCTAssertEqual(jReq.getChildPath(), "j999")
    }
    
    func testLocationDBCreate() {
        let expected = Location(locID: ID(type: "l", uuid: "999"), name: "test loc", number: "444", street: "test street", street2: "boulevard", city: "Testopia", state: "AK", zip: 99987, country: "United States of Testing")
        
        let key = "l999"
        let payload = ["city": "Testopia",
                       "name": "test loc",
                       "country": "United States of Testing",
                       "street": "test street",
                       "street2": "boulevard",
                       "state": "AK",
                       "zip": 99987,
                       "number": "444"] as [String: AnyObject]
        
        XCTAssertEqual(expected, Location(key: key, payload: payload))
    }
    
    func testLocationDBFuncs() {
        let test = Location(locID: ID(type: "l", uuid: "999"), name: "test loc", number: "444", street: "test street", street2: "boulevard", city: "Testopia", state: "AK", zip: 99987, country: "United States of Testing")
        
        XCTAssertEqual(test.getTable(), FirTable.location)
        XCTAssertEqual(test.getChildPath(), "l999")
    }
    
    func testLocationDescribe() {
        let test = Location(locID: ID(type: "l", uuid: "999"), name: "test loc", number: "444", street: "test street", street2: "boulevard", city: "Testopia", state: "AK", zip: 99987, country: "United States of Testing")
        
        XCTAssertEqual(test.description, "444 test street\nboulevard\nTestopia, AK 99987\nUnited States of Testing")
    }
    
    func testMediaDBCreate() {
        let expected = Media(url: "foo/test/url.comnetgov", mediaID: ID(type: "m", uuid: "999"))
        
        let key = "m999"
        let payload = ["url": "foo/test/url.comnetgov"] as [String: AnyObject]
        
        XCTAssertEqual(expected, Media(key: key, payload: payload))
    }
    
    func testMediaDBFuncs() {
        let test = Media(url: "foo/test/url.comnetgov", mediaID: ID(type: "m", uuid: "999"))
        
        XCTAssertEqual(test.getTable(), FirTable.media)
        XCTAssertEqual(test.getChildPath(), "m999")
    }
    
    func testOrganizationDBCreate() {
        let expected = Organization(orgID: ID(type: "o", uuid: "999"), name: "test org", locationID: ID(type: "l", uuid: "999"), teamIDs: [tID999: tID999])
        
        let key = "o999"
        let payload =  ["name": "test org",
                        "locationID": "l999",
                        "teamIDs": ["t999":"t999"]] as [String: AnyObject]
        
        XCTAssertEqual(expected, Organization(key: key, payload: payload))
    }
    
    func testOrganizationDBFuncs() {
        let test = Organization(orgID: ID(type: "o", uuid: "999"), name: "test org", locationID: ID(type: "l", uuid: "999"), teamIDs: [tID999: tID999])
        
        XCTAssertEqual(test.getTable(), FirTable.organization)
        XCTAssertEqual(test.getChildPath(), "o999")
    }
    
    func testPlayerPermsDBCreate() {
        let expected = PlayerPerms(teamID: tID999, userID: ID(type: "u", uuid: "999"), permissions: [Permissions.editCalendar, Permissions.editStats])
        
        let key = "t999"
        let payload = ["permissions": ["EditAttendance", "EditStats"],
                       "userID": "u999"] as [String: AnyObject]
        
        XCTAssertEqual(expected, PlayerPerms(key: key, payload: payload))
    }
    
    func testPlayerPermsDBFuncs() {
        let test = PlayerPerms(teamID: tID999, userID: ID(type: "u", uuid: "999"), permissions: [Permissions.editCalendar, Permissions.editStats])
        
        XCTAssertEqual(test.getTable(), FirTable.playerPerms)
        XCTAssertEqual(test.getChildPath(), "u999/t999")
    }
    
    func testRsvpDBCreate() {
        let expected = RSVP(eventID: ID(type: "e", uuid: "999"), yesUserIDs: [ID(type: "u", uuid: "999")], noUserIDs: [ID(type: "u", uuid: "999")], pendingUserIDs: [ID(type: "u", uuid: "999")])
        
        let key = "e999"
        let payload = ["yesUserIDs": ["u999"],
                       "noUserIDs": ["u999"],
                       "pendingUserIDs": ["u999"]] as [String: AnyObject]
        
        XCTAssertEqual(expected, RSVP(key: key, payload: payload))
    }
    
    func testRsvpDBFuncs() {
        let test = RSVP(eventID: ID(type: "e", uuid: "999"), yesUserIDs: [ID(type: "u", uuid: "999")], noUserIDs: [ID(type: "u", uuid: "999")], pendingUserIDs: [ID(type: "u", uuid: "999")])
        
        XCTAssertEqual(test.getTable(), FirTable.rsvp)
        XCTAssertEqual(test.getChildPath(), "e999")
    }
    
    func testTeamDBCreate() {
        let expected = Team(teamID: tID999, orgID: ID(type: "o", uuid: "999"), userIDs: [uID999: uID999], teamName: "test team", sport: "test sport", joinReqIDs: [:], blacklistUserIDs: [uID999: uID999])
        
        let key = "t999"
        let payload = ["blacklistUserIDs": ["u999":"u999"],
                       "joinRequestIDs": ["j999"],
                       "orgID": "o999",
                       "sport": "test sport",
                       "teamName": "test team",
                       "nextPractice": "z0",
                       "nextEvent": "z0",
                       "userIDs": ["u999":"u999"]] as [String: AnyObject]
        
        XCTAssertEqual(expected, Team(key: key, payload: payload))
    }
    
    func testTeamDBFuncs() {
        let test = Team(teamID: tID999, orgID: ID(type: "o", uuid: "999"), userIDs: [uID999: uID999], teamName: "test team", sport: "test sport", joinReqIDs: [ID(type: "j", uuid: "999"): ID(type: "j", uuid: "999")], blacklistUserIDs: [uID999: uID999])
        
        XCTAssertEqual(test.getTable(), FirTable.team)
        XCTAssertEqual(test.getChildPath(), "t999")
    }
    
    func testTeamCalendarDBCreate() {
        let expected = TeamCalendar(teamID: tID999, eventIDs: [IDUtility.generateIDFromString(idString: "e999")])
        
        let key = "t999"
        let payload = ["eventIDs": ["e999"]] as [String: AnyObject]
        
        XCTAssertEqual(expected, TeamCalendar(key: key, payload: payload))
    }
    
    func testTeamCalendarDBFuncs() {
        let test = TeamCalendar(teamID: tID999, eventIDs: [ID(type: "e", uuid: "999"
            )])
        
        XCTAssertEqual(test.getTable(), FirTable.teamCalendar)
        XCTAssertEqual(test.getChildPath(), "t999")
    }
    
    func testTeamStatsDBFuncs() {
        let test = TeamStats(teamID: tID999, memberCount: 8, wins: 50, losses: 20, ties: 10, fields: ["Detective": "Jake Peralta"])
        
        XCTAssertEqual(test.getTable(), FirTable.teamStats)
        XCTAssertEqual(test.getChildPath(), "t999")
    }
    
    func testTeamStatsDBCreate() {
        let expected = TeamStats(teamID: tID999, memberCount: 8, wins: 50, losses: 20, ties: 10, fields: ["Detective": "Jake Peralta"])
        
        let key = "t999"
        let payload = ["memberCount": 8,
                       "wins": 50,
                       "losses": 20,
                       "fields": ["Detective": "Jake Peralta"],
                       "ties": 10] as [String: AnyObject]
        
        XCTAssertEqual(expected, TeamStats(key: key, payload: payload))
    }
    
    func testUserDBFuncs() {
        let test = User(userID: ID(type: "u", uuid: "999"), firstName: "Bam", lastName: "Zon", nickname: "BZN", phone: "8675309", email: "bzn@bamzon.co.uk", schoolYear: Year.fourthYear, bio: "309 app", imageURL: nil, teamIDs: [tID999: tID999])
        
        XCTAssertEqual(test.getTable(), FirTable.user)
        XCTAssertEqual(test.getChildPath(), "u999")
    }
    
    func testUserDBCreate() {
        let expected = User(userID: ID(type: "u", uuid: "999"), firstName: "Bam", lastName: "Zon", nickname: "BZN", phone: "8675309", email: "bzn@bamzon.co.uk", schoolYear: Year.fourthYear, bio: "309 app", imageURL: "", teamIDs: [tID999: tID999])
        
        let key = "u999"
        let payload = ["firstName": "Bam",
                       "lastName": "Zon",
                       "nickname": "BZN",
                       "phone": "8675309",
                       "email": "bzn@bamzon.co.uk",
                       "schoolYear": 4,
                       "bio": "309 app",
                       "imageURL": "",
                       "teamIDs": ["t999":"t999"]] as [String: AnyObject]
        
        XCTAssertEqual(expected, User(key: key, payload: payload))
    }
    
    func testFirebaseIDDBFuncs() {
        let test = FirebaseID(userID: ID(type: "u", uuid: "999"), firebaseID: "4F33eBzUWgY03almiHpkLH5q9OY2")
        
        XCTAssertEqual(test.getTable(), FirTable.firebaseID)
        XCTAssertEqual(test.getChildPath(), "4F33eBzUWgY03almiHpkLH5q9OY2")
    }
    
    func testFirebaseIDDBCreate() {
        let expected = FirebaseID(userID: ID(type: "u", uuid: "999"), firebaseID: "4F33eBzUWgY03almiHpkLH5q9OY2")
        
        let key = "4F33eBzUWgY03almiHpkLH5q9OY2"
        let payload = ["userID": "u999"] as [String: AnyObject]
        
        XCTAssertEqual(expected, FirebaseID(key: key, payload: payload))
    }

//    func testDateToString() {
//      let cal = Calendar.current;
//        
//        var dateComponents = DateComponents()
//        dateComponents.year = 1999
//        dateComponents.month = 1
//        dateComponents.day = 30
//        dateComponents.hour = 11
//        dateComponents.minute = 45
//        dateComponents.timeZone = TimeZone(abbreviation: "PST")
//        let date = cal.date(from: dateComponents)
//        
//        XCTAssertEqual(date?.toString() ?? "nope", "1999-01-30 11:45 -0800")
//        XCTAssertEqual(date?.toStringNoTZMinSec() ?? "nope", "1999-01-30")
//        XCTAssertEqual(date?.prettyPrint() ?? "nope", "1999-01-30 @ 11:45 AM")
//        XCTAssertEqual(date?.toStringPretty() ?? "nope", "01/30/1999")
//    }
//    
//    func testStringToDate() {
//        let string = "1999-01-30 11:45 -0800"
//        let cal = Calendar.current
//        
//        var dateComponents = DateComponents()
//        dateComponents.year = 1999
//        dateComponents.month = 1
//        dateComponents.day = 30
//        dateComponents.hour = 11
//        dateComponents.minute = 45
//        dateComponents.timeZone = TimeZone.current
//        
//      XCTAssertEqual(Date.fromString(from: string), cal.date(from: dateComponents))
//    }
//    
//    func testStringToDate2() {
//        let string = "1969-12-31 04:00 -0800"
//        let cal = Calendar.current
//        
//        var dateComponents = DateComponents()
//        dateComponents.year = 1969
//        dateComponents.month = 12
//        dateComponents.day = 31
//        dateComponents.hour = 04
//        dateComponents.minute = 00
//        dateComponents.timeZone = TimeZone.current
//        XCTAssertEqual(Date.fromString(from: string), cal.date(from: dateComponents))
//    }
    
    func testUserGetFullName() {
        let test = User(userID: ID(type: "u", uuid: "999"), firstName: "Bam", lastName: "Zon", nickname: "BZN", phone: "8675309", email: "bzn@bamzon.co.uk", schoolYear: Year.fourthYear, bio: "309 app", imageURL: nil, teamIDs: [uID999: uID999])
        
        XCTAssertEqual("BZN Zon", test.getFullName())
        
        let test2 = User(userID: ID(type: "u", uuid: "999"), firstName: "Bam", lastName: "Zon", nickname: nil, phone: "8675309", email: "bzn@bamzon.co.uk", schoolYear: Year.fourthYear, bio: "309 app", imageURL: nil, teamIDs: [uID999: uID999])
        
        XCTAssertEqual("Bam Zon", test2.getFullName())
    }
    
    func testCompareEvents() {
        let latest = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "latest", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: Date(timeIntervalSinceNow: 1000), tags: ["test": "test"], media: [:], links: [:])
        let middle = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "middle", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: Date(timeIntervalSinceNow: 100), tags: ["test": "test"], media: [:], links: [:])
        let soonest = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "soonest", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: Date(timeIntervalSinceNow: 0), tags: ["test": "test"], media: [:], links: [:])
        
        let list = [latest, middle, soonest]
        let sorted = list.sorted()
        let expected = [soonest, middle, latest]
        
        XCTAssertEqual(sorted, expected)
    }
    
    func testCompareEventsWithNil() {
        let latest = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "latest", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: Date(timeIntervalSinceNow: 1000), tags: ["test": "test"], media: [:], links: [:])
        let middle = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "middle", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: Date(timeIntervalSinceNow: 100), tags: ["test": "test"], media: [:], links: [:])
        let nilEvent = Event(eventID: ID(type: "e", uuid: "999"), teamID: tID999, name: "soonest", locationID: nil, contactUserIDs: [uID999: uID999], description: "test event description", date: nil, tags: ["test": "test"], media: [:], links: [:])
        
        let list = [nilEvent, latest, middle]
        let sorted = list.sorted()
        let expected = [middle, latest, nilEvent]
        
        XCTAssertEqual(sorted, expected)
    }
}
