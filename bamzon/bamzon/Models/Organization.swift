//
//  Organization.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Organization: FirebaseCompatable, Equatable, Comparable {
    
    var orgID: ID
    var name: String
    var locationID: ID
    var teamIDs: [ID : ID]

    init(orgID: ID, name: String, locationID: ID, teamIDs: [ID: ID]) {
        self.orgID = orgID
        self.name = name
        self.locationID = locationID
        self.teamIDs = teamIDs
    }
    
    init (key: String, payload: [String: AnyObject]) {
        orgID = IDUtility.generateIDFromString(idString: key)
        name = payload["name"] as? String ?? "N/A"
        locationID = IDUtility.generateIDFromString(idString: payload["locationID"] as? String ?? "z0")
        teamIDs = IDUtility.stringsToIDDict(strs: payload["teamIDs"] as? [String : String] ?? [:])
    }
    
    static func < (lhs: Organization, rhs: Organization) -> Bool {
        return lhs.name < rhs.name
    }

    func formatForDB() -> [String: Any] {
        return
            ["name": name,
             "locationID": locationID.toString(),
             "teamIDs": IDUtility.idsToDict(ids: teamIDs)]
    }

    func getTable() -> FirTable {
        return FirTable.organization
    }
    func getChildPath() -> String {
        return orgID.toString()
    }

}
