//
//  Permissions.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct PlayerPerms: FirebaseCompatable, Equatable {
    var teamID: ID
    var userID: ID
    var permissions: [Permissions]
    
    init(teamID: ID, userID: ID, permissions: [Permissions]) {
        self.teamID = teamID
        self.userID = userID
        self.permissions = permissions
    }
    
    init(key: String, payload: [String: AnyObject]) {
        teamID = IDUtility.generateIDFromString(idString: key)
        userID = IDUtility.generateIDFromString(idString: payload["userId"] as? String ?? "z0")
        permissions = stringsToPerms(strs: payload["permissions"] as? [String] ?? [])
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["permissions": permsToStrings(perms: permissions),
             "userId": userID.asString()]
    }
    
    func getTable() -> FirTable {
        return FirTable.playerPerms
    }
    
    func getChildPath() -> String {
        return "\(userID.asString())/\(teamID.asString())"
    }
}

func permsToStrings(perms: [Permissions]) -> [String] {
    var strArr = [String]()
    perms.forEach { perm in
        strArr.append(perm.rawValue)
    }
    return strArr
}

func stringsToPerms(strs: [String]) -> [Permissions] {
    var permArr = [Permissions]()
    strs.forEach { str in
        permArr.append(Permissions(rawValue: str) ?? Permissions.permError)
    }
    return permArr
}

enum Permissions: String {
    case editTeamInfo = "EditTeamInfo"
    case manageJoinRequests = "ManageJoinRequests"
    case editRoster = "EditRoster"
    case editCalendar = "EditAttendance"
    case editStats = "EditStats"
    case permError = "PermissionsError"
}
