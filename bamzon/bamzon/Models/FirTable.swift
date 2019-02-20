//
//  FirTables.swift
//  bamzon
//
//  Created by Daniel Heyde on 2/19/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

// index by model class name
enum FirTable: String {
    case playerStats = "playerStats"
    case event = "events"
    case joinRequest = "joinRequests"
    case location = "locations"
    case media = "media"
    case organization = "organizations"
    case playerPerms = "playerPermissions"
    case rsvp = "RSVPs"
    case team = "teams"
    case teamCalendar = "teamCalendars"
    case teamStats = "teamStats"
    case user = "users"
}
