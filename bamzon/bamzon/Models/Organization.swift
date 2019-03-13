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
    var location: Location?
    var teamIDs: [ID]

    init(orgID: ID, name: String, location: Location?, teamIDs: [ID]) {
        self.orgID = orgID
        self.name = name
        self.location = location
        self.teamIDs = teamIDs
    }
    
    init (key: String, payload: [String: AnyObject]) {
        orgID = IDUtility.generateIDFromString(idString: key)
        name = payload["name"] as? String ?? "N/A"
        location = nil
        teamIDs = IDUtility.stringsToIDs(strs: payload["teamIDs"] as? [String] ?? [])

        let locIDString = payload["location"] as? String ?? "NoLocFound"
        print("(\(orgID.asString())) loc id string is \(locIDString)")
        
        if locIDString != "" && locIDString != "NoLocFound" {
            var thisOrg = self
            print("fetching location of id: \(locIDString)")
            let locationID = IDUtility.generateIDFromString(idString: locIDString)
            DBUtility.readFromDB(table: FirTable.location, keys: locationID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                thisOrg.location = Location(key: key, payload: payload)
                print("org location worked. org: \(thisOrg)")
            })
        } else {
            print("no location to fetch for org \(orgID.asString())")
        }
    }

    func formatForDB() -> [String: Any] {
        return
            ["name": name,
             "location": location?.locID.asString() ?? "",
             "teamIDs": IDUtility.idsToStrings(ids: teamIDs)]
    }

    func getTable() -> FirTable {
        return FirTable.organization
    }
    func getChildPath() -> String {
        return orgID.asString()
    }

}
