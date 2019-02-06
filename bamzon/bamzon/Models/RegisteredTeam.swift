//
//  RegisteredTeam.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RegisteredTeam {
    var regID: ID
    var teamID: ID
    var stats: [ID: PlayerStats]?
    var permissionsPerUser: [ID: [Permissions]]?
    let ref: DatabaseReference?
    
    
    init(regID: ID, teamID: ID, stats: [ID: PlayerStats]?, permissions: [ID: [Permissions]]) {
        self.regID = regID
        self.teamID = teamID
        self.stats = stats
        self.permissionsPerUser = permissions
        ref = nil
    }
    
    init(){
        self.regID = ID(type: IdType.regTeam, num: 0)
        self.teamID = ID(type: IdType.team, num: 0)
        self.stats = [:]
        self.permissionsPerUser = [:]
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        
        let snapvalues = snapshot.value as! [String : AnyObject]
        
        regID = snapvalues["teamID"] as? ID ?? ID(type: IdType.team, num: 0)
        teamID = snapvalues["orgID"] as? ID ?? ID(type: IdType.org, num: 0)
        
        for stat in (snapshot.childSnapshot(forPath: "stats").children.allObjects as! [DataSnapshot]) {
            stats![IDUtility.generateIDFromString(idString: stat.key)] = PlayerStats(key: stat.key, snapshot: stat)
        }
        
        for permissions in (snapshot.childSnapshot(forPath: "stats").children.allObjects as! [DataSnapshot]) {
            var permissionsArray = [Permissions]()
            for permission in (snapshot.childSnapshot(forPath: "stats").childSnapshot(forPath: permissions.key).children.allObjects as! [DataSnapshot]) {
                permissionsArray.append(Permissions(rawValue: permission.value as! String)!)
            }
            permissionsPerUser?[IDUtility.generateIDFromString(idString: permissions.key)] = permissionsArray
        }
        
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        var anyStats = [String:Any]()
        if stats != nil {
            for stat in stats! {
                anyStats[stat.key.getString()] = stat.value.toAnyObject()
            }
        }
        
        var anyPermissionsPerUser = [String:[Any]]()
        if permissionsPerUser != nil {
            for permissions in permissionsPerUser! {
                var anyPermissions = [Any]()
                for permission in permissions.value {
                    anyPermissions.append(permission.rawValue)
                }
                anyPermissionsPerUser[permissions.key.getString()] = anyPermissions
            }
        }
        
        return [
            "regID" : regID,
            "teamID" : teamID,
            "stats" : anyStats,
            "permission" : anyPermissionsPerUser
        ]
    }
}
