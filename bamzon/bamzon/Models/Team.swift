//
//  Team.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct Team {
    var teamID: UInt
    var orgID: UInt
    var userIDs: [UInt]?
    var teamName: String
    var sport: String? // TODO: should sport be an optional?
    var stats: TeamStats
    var calendar: TeamCalendar
    var joinRequests: [JoinRequest]?
    var blacklistUserIDs: [UInt]?
}
