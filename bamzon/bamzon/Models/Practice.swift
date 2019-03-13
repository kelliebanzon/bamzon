//
//  File.swift
//  bamzon
//
//  Created by liblabs-mac on 3/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Firebase
import Foundation

struct Practice: FirebaseCompatable, Comparable {
    var teamID: ID
    var event: Event?
    var attendingUsers: [ID]
    
    init(teamID: ID, event: Event, users: [ID]) {
        self.teamID = teamID
        self.event = event
        self.attendingUsers = users
    }
    
    init(key: String, payload: [String: AnyObject]) {
        teamID = IDUtility.generateIDFromString(idString: key)
        attendingUsers = IDUtility.stringsToIDs(strs: payload["attendingUsers"] as? [String] ?? [])
        let eventID = IDUtility.generateIDFromString(idString: payload["eventID"] as? String ?? "z0")
        event = nil
        
        var thisPractice = self
        
        if teamID != ID(type: "z", uuid: "0") {
            DBUtility.readFromDB(table: FirTable.event, keys: eventID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                thisPractice.event = Event(key: key, payload: payload)
            })
        }
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["eventID": event?.eventID.asString() ?? "z0",
             "attendingUsers": IDUtility.idsToStrings(ids: attendingUsers)]
    }
    
    func getTable() -> FirTable {
        return FirTable.practice
    }
    
    func getChildPath() -> String {
        return teamID.asString()
    }
    
    static func < (lhs: Practice, rhs: Practice) -> Bool {
        if lhs.event == nil {
            return false
        }
        if rhs.event == nil {
            return true
        }
        return lhs.event! < rhs.event!
    }
    
}
