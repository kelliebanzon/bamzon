//
//  JoinRequest.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct JoinRequest: FirebaseCompatable, Equatable {
    var userID: ID
    var teamID: ID
    var joinReqID: ID

    init(joinReqID: ID, userID: ID, teamID: ID) {
        self.userID = userID
        self.teamID = teamID
        self.joinReqID = joinReqID
    }
    
    init(key: String, payload: [String: AnyObject]) {
        joinReqID = IDUtility.generateIDFromString(idString: key)
        userID = IDUtility.generateIDFromString(idString: payload["userID"] as? String ?? "z0")
        teamID = IDUtility.generateIDFromString(idString: payload["teamID"] as? String ?? "z0")
    }
    
    func formatForDB() -> [String: Any] {
        return ["userID": userID.toString(),
                "teamID": teamID.toString()]
    }
    
    func getTable() -> FirTable {
        return FirTable.joinRequest
    }
    
    func getChildPath() -> String {
        return joinReqID.toString()
    }
}
