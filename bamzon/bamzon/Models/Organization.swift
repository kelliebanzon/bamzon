//
//  Organization.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Organization: FirebaseCompatable {
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
    
    init (snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        orgID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        name = payload["name"] as? String ?? "N/A"
        location = nil
        teamIDs = IDUtility.stringsToIds(strs: payload["teams"] as? [String] ?? [])

        let locIDString = payload["location"] as? String ?? "NoLocFound"
        print("(\(orgID.asString())) loc id string is \(locIDString)")
        
        if locIDString != "" && locIDString != "NoLocFound" {
            var thisOrg = self
            print("fetching location of id: \(locIDString)")
            let locationID = IDUtility.generateIDFromString(idString: locIDString)
            DBUtility.readFromDB(table: "locations", keys: locationID, completion: {(locSnap: DataSnapshot) -> Void in
                thisOrg.location = Location(snapshot: locSnap)
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
             "teamIds": IDUtility.idsToStrings(ids: teamIDs)]
    }

    func getTable() -> String {
        return "organizations"
    }
    func getChildPath() -> String {
        return orgID.asString()
    }

}
