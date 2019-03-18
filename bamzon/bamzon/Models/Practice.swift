//
//  File.swift
//  bamzon
//
//  Created by liblabs-mac on 3/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Firebase
import Foundation

struct Practice: FirebaseCompatable, Equatable {
    var teamID: ID
    var eventID: ID
    var date: Date
    var attendingUsers: [ID:ID]
    var excusedUsers: [ID:ID]
    
    init(teamID: ID, eventID: ID, date: Date, attendingUsers: [ID:ID], excusedUsers: [ID:ID]) {
        self.teamID = teamID
        self.eventID = eventID
        self.date = date
        self.attendingUsers = attendingUsers
        self.excusedUsers = excusedUsers
    }
    
    init(key: String, payload: [String: AnyObject]) {
        eventID = IDUtility.generateIDFromString(idString: key)
        attendingUsers = IDUtility.stringsToIDDict(strs: payload["attendingUsers"] as? [String:String] ?? [:])
        excusedUsers = IDUtility.stringsToIDDict(strs: payload["excusedUsers"] as? [String:String] ?? [:])
        teamID = IDUtility.generateIDFromString(idString: payload["teamID"] as? String ?? "z0")
        date = Date.fromString(from: payload["date"] as? String ?? "1920-01-01 00:00 -0000")
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["excusedUsers": IDUtility.idsToDict(ids: excusedUsers),
             "attendingUsers": IDUtility.idsToDict(ids: attendingUsers),
             "date": date.toString(),
             "teamID": teamID.toString()]
    }
    
    func getTable() -> FirTable {
        return FirTable.practice
    }
    
    func getChildPath() -> String {
        return "\(teamID.toString())/\(eventID.toString())"
    }
    
}
