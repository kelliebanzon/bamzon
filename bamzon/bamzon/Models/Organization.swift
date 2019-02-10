//
//  Organization.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct Organization {
    var orgID: ID
    var name: String
    var location: Location
    var teamIDs: [ID]

    init(orgID: ID, name: String, location: Location, teamIDs: [ID]){
        self.orgID = orgID
        self.name = name
        self.location = location
        self.teamIDs = teamIDs
    }
}
