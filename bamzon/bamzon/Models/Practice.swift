//
//  File.swift
//  bamzon
//
//  Created by liblabs-mac on 3/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Firebase
import Foundation

struct Practice: FirebaseCompatable {
    var teamID: ID
    var eventID: ID
    var attendingUsers: [ID]
    
    init(teamID: ID, eventID: ID, users: [ID]) {
        self.teamID = teamID
        self.eventID = eventID
        self.attendingUsers = users
    }
    
    init(key: String, payload: [String: AnyObject]) {
        teamID = IDUtility.generateIDFromString(idString: key)
        attendingUsers = IDUtility.stringsToIDs(strs: payload["attendingUsers"] as? [String] ?? [])
        eventID = IDUtility.generateIDFromString(idString: payload["eventID"] as? String ?? "z0")
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["eventID": eventID.toString(),
             "attendingUsers": IDUtility.idsToStrings(ids: attendingUsers)]
    }
    
    func getTable() -> FirTable {
        return FirTable.practice
    }
    
    func getChildPath() -> String {
        return teamID.toString()
    }
    
}
