//
//  PlayerAttendance.swift
//  bamzon
//
//  Created by liblabs-mac on 3/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

struct PlayerAttendance: FirebaseCompatable {
    var userID: ID
    var teamID: ID
    var presentPractices: [ID]
    
    init(userID: ID, teamID: ID, presentPractices: [ID]) {
        self.userID = userID
        self.presentPractices = presentPractices
        self.teamID = teamID
    }
    
    init(key: String, payload: [String: AnyObject]) {
        userID = IDUtility.generateIDFromString(idString: key)
        presentPractices = IDUtility.stringsToIDs(strs: payload["presentPractices"] as? [String] ?? [])
        teamID = IDUtility.generateIDFromString(idString: payload["teamID"] as? String ?? "z0")
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["presentPractices": IDUtility.idsToStrings(ids: presentPractices)]
    }
    
    func getTable() -> FirTable {
        return FirTable.playerAttendance
    }
    
    func getChildPath() -> String {
        return "\(userID.asString())/\(teamID.asString())"
    }
    
}
