//
//  Organization.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Organization {
    var orgID: ID
    var name: String
    var location: Location
    var teamIDs: [ID]
    let ref: DatabaseReference?
    
    init(orgID: ID, name: String, location: Location, teamIDs: [ID]){
        self.orgID = orgID
        self.name = name
        self.location = location
        self.teamIDs = teamIDs
        ref = nil
    }
    
    init(){
        orgID = ID()
        name = "N/A"
        location = Location()
        teamIDs = []
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        let snapvalues = snapshot.value as! [String : AnyObject]
        orgID = snapvalues["orgID"] as? ID ?? ID()
        name = snapvalues["name"] as? String ?? "N/A"
        location = snapvalues["location"] as? Location ?? Location()
        
        for teamID in (snapshot.childSnapshot(forPath:
            "teamIDs").children.allObjects as! [DataSnapshot]){
                teamIDs.append(ID(key: teamID.key, snapshot: teamID))
        }
        
        ref = snapshot.ref

    }
    
    func toAnyObject() -> Any {
        return [
            "orgID" : orgID,
            "name" : name,
            "location" : location,
            "teamIDS" : teamIDs
        ]
    }
    
    
}
