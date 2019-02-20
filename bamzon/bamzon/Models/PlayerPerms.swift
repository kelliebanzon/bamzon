//
//  Permissions.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct PlayerPerms: FirebaseCompatable {
    var teamID: ID
    var userID: ID
    var permissions: [Permissions]
    
    init(teamID: ID, userID: ID, permissions: [Permissions]) {
        self.teamID = teamID
        self.userID = userID
        self.permissions = permissions
    }
    
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        teamID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        userID = IDUtility.generateIDFromString(idString: payload["userId"] as? String ?? "z0")
        permissions = payload["permissions"] as? [String] ?? []
    }
    
    func formatForDB() -> [String : Any] {
        return
            ["permissions": permissions]
    }
    
    func getTable() -> String {
        return "playerPermissions"
    }
    
    func getChildPath() -> String {
        return "\(userID.asString())/\(teamID.asString())"
    }
    
    func permsToStrings(perms: [Permissions]) -> [String] {
        var strArr = [](Permissions)
        perms.forEach { perm in
            strArr.apend(perm.rawValue)
        }
        return strArr
    }
    
    func stringsToPerms(strs: [String]) -> [Permissions] {
        var permArr = [](Permissions)
        strs.forEach { str in
            permArr.apend(Permissions.str)
        }
        return permArr
    }
}

enum Permissions: String {
    case editTeamInfo = "EditTeamInfo"
    case manageJoinRequests = "ManageJoinRequests"
    case editRoster = "EditRoster"
    case editCalendar = "EditAttendance"
    case editStats = "EditStats"
}
