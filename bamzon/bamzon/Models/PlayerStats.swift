//
//  PlayerStats.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct PlayerStats: FirebaseCompatable {
    var fields: [String: Any]?
    var userID: ID
    var teamID: ID
    
    init(userID: ID, teamID: ID, fields: [String: Any]?) {
        self.fields = fields
        self.userID = userID
        self.teamID = teamID
    }
    
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        userID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        teamID = IDUtility.generateIDFromString(idString: payload["teamId"] as? String ?? "z0")
        fields = payload["fields"] as? [String: Any] ?? [:]
    }
    
    func formatForDB() -> [String : Any] {
        return
            ["fields": fields ?? [:],
             "teamID": teamID.asString()]
    }
    
    func getTable() -> String {
        return "playerStats"
    }
    
    func getChildPath() -> String {
        return "\(teamID.asString())/\(userID.asString())"
    }
    
}
