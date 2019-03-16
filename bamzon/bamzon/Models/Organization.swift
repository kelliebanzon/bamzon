//
//  Organization.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Organization: FirebaseCompatable, Equatable {
    var orgID: ID
    var name: String
    var locationID: ID
    var teamIDs: [ID]

    init(orgID: ID, name: String, locationID: ID, teamIDs: [ID]) {
        self.orgID = orgID
        self.name = name
        self.locationID = locationID
        self.teamIDs = teamIDs
    }
    
    init (key: String, payload: [String: AnyObject]) {
        orgID = IDUtility.generateIDFromString(idString: key)
        name = payload["name"] as? String ?? "N/A"
        locationID = IDUtility.generateIDFromString(idString: payload["location"] as? String ?? "z0")
        teamIDs = IDUtility.stringsToIDs(strs: payload["teamIDs"] as? [String] ?? [])
    }

    func formatForDB() -> [String: Any] {
        return
            ["name": name,
             "locationID": locationID.asString(),
             "teamIDs": IDUtility.idsToStrings(ids: teamIDs)]
    }

    func getTable() -> FirTable {
        return FirTable.organization
    }
    func getChildPath() -> String {
        return orgID.asString()
    }

}
