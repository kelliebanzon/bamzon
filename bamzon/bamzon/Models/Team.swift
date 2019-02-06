//
//  Team.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Team {
    var teamID: ID
    var orgID: ID
    var userIDs: [ID]?
    var teamName: String
    var sport: String? // TODO: should sport be an optional?
    var stats: TeamStats
    var calendar: TeamCalendar
    var joinRequests: [JoinRequest]?
    var blacklistUserIDs: [ID]?
    let ref: DatabaseReference?
    
    init(teamID: ID, orgID: ID, userIDs: [ID]?, teamName: String, sport: String?, stats: TeamStats, calendar: TeamCalendar, joinRequests: [JoinRequest], blacklistUserIDs: [ID]?) {
        self.teamID = teamID
        self.orgID = orgID
        self.userIDs = userIDs
        self.teamName = teamName
        self.sport = sport
        self.stats = stats
        self.calendar = calendar
        self.joinRequests = joinRequests
        self.blacklistUserIDs = blacklistUserIDs
        ref = nil
    }
    
    init(){
        teamID = ID(type: IdType.team, num: 0)
        orgID = ID(type: IdType.org, num: 0)
        teamName = "N/A"
        stats = TeamStats()
        calendar = TeamCalendar()
        joinRequests = []
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        
        let snapvalues = snapshot.value as! [String : AnyObject]
        
        teamID = snapvalues["teamID"] as? ID ?? ID(type: IdType.team, num: 0)
        orgID = snapvalues["orgID"] as? ID ?? ID(type: IdType.org, num: 0)
        teamName = snapvalues["teamName"] as? String ?? "N/A"
        sport = snapvalues["sport"] as? String ?? nil
        stats = snapvalues["stats"] as? TeamStats ?? TeamStats()
        calendar = snapvalues["calendar"] as? TeamCalendar ?? TeamCalendar()
        
        
        
        for request in (snapshot.childSnapshot(forPath: "joinRequests").children.allObjects as! [DataSnapshot]) {
            joinRequests!.append(JoinRequest(key: request.key, snapshot: request))
        }
        
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        var anyUserIDs = [Any]()
        if userIDs != nil {
            for userID in userIDs! {
                anyUserIDs.append(userID.getString())
            }
        }
        
        var anyJoinRequests = [Any]()
        if joinRequests != nil {
            for joinRequest in joinRequests! {
                anyJoinRequests.append(joinRequest.toAnyObject())
            }
        }
       
        var anyBlacklistIds = [Any]()
        if blacklistUserIDs != nil {
            for blacklistId in blacklistUserIDs! {
                anyBlacklistIds.append(blacklistId.getString())
            }
        }
        
        return [
            "teamID" : teamID.getString(),
            "orgID" : orgID.getString(),
            "userIDs" : anyUserIDs,
            "teamName": teamName,
            "sport" : sport ?? "",
            "stats" : stats,
            "calendar" : calendar.toAnyObject(),
            "joinRequests" : anyJoinRequests,
            "blacklistUserIDs" : anyBlacklistIds
        ]
    }
}




