//
//  Team.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct Team {
    var teamID: ID
    var orgID: ID
    var userIDs: [ID]?
    var teamName: String
    var sport: String? // TODO: should sport be an optional?
    var stats: TeamStats
    var calendar: TeamCalendar
    var joinRequests: [JoinRequest]?
    var blacklistUserIDs: [ID]?

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
    }
}
