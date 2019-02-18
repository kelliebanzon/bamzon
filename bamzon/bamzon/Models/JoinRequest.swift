//
//  JoinRequest.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct JoinRequest: FirebaseCompatable {
    var userID: ID
    var teamID: ID
    var joinReqID: ID

    init(joinReqID: ID, userID: ID, teamID: ID) {
        self.userID = userID
        self.teamID = teamID
        self.joinReqID = joinReqID
    }
    
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        joinReqID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        userID = IDUtility.generateIDFromString(idString: payload["userId"] as? String ?? "z0")
        teamID = IDUtility.generateIDFromString(idString: payload["teamId"] as? String ?? "z0")
    }
    
    func formatForDB() -> [String: Any] {
        return ["userId": userID.asString(),
                "teamId": teamID.asString()]
    }
    
    func getTable() -> String {
        return "joinRequests"
    }
    
    func getChildPath() -> String {
        return joinReqID.asString()
    }
}
