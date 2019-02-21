//
//  Event.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Event: FirebaseCompatable {
    var name: String
    var location: Location?
    var contactUserIDs: [ID]?
    var description: String?
    var date: String?
    var rsvps: RSVP?
    var tags: [String]?
    var media: [String: Media]?
    var links: [String: String]? // TODO: should this be a url or a string?
    var eventID: ID
    var teamID: ID
    
    init(eventID: ID, teamID: ID, name: String, location: Location?, contactUserIDs: [ID]?, description: String?, date: String?, rsvps: RSVP?, tags: [String]?, media: [String: Media]?, links: [String: String]?) {
        self.name = name
        self.location = location
        self.contactUserIDs = contactUserIDs
        self.description = description
        self.date = date
        self.rsvps = rsvps
        self.tags = tags
        self.media = media
        self.links = links
        self.eventID = eventID
        self.teamID = teamID
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["name": name,
             "teamId": teamID.asString(),
             "location": location?.locID.asString() ?? "",
             "contactUserIds": IDUtility.idsToStrings(ids: contactUserIDs),
             "description": description ?? "",
             "date": date ?? "",
             "tags": tags ?? [],
             "media": media ?? [:],
             "links": links ?? [:]]
    }
    
    func getTable() -> FirTable {
        return FirTable.event
    }
    
    func getChildPath() -> String {
        return "\(eventID.asString())"
    }
    
    init(snapshot: DataSnapshot?) {
        eventID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        name = payload["name"] as? String ?? "N/A"
        location = nil
        contactUserIDs = IDUtility.stringsToIds(strs: payload["contactUserIds"] as? [String] ?? [])
        description = payload["description"] as? String ?? "N/A"
        date = payload["date"] as? String ?? "N/A"
        rsvps = nil
        tags = payload["tags"] as? [String] ?? []
        media = payload["media"] as? [String: Media] ?? [:]
        links = payload["links"] as? [String: String] ?? [:]
        teamID = IDUtility.generateIDFromString(idString: payload["teamId"] as? String ?? "z0")

        let locIDString = payload["location"] as? String ?? "NoLocFound"
        var thisEvent = self
        print("fetching location of id: \(locIDString)")
        
        if locIDString != "" && locIDString != "NoLocFound" {
            let locationID = IDUtility.generateIDFromString(idString: locIDString)
            DBUtility.readFromDB(table: FirTable.location, keys: locationID, completion: {(locSnap: DataSnapshot) -> Void in
                thisEvent.location = Location(snapshot: locSnap)
                print("event location fetch succeeded: event is \(thisEvent)")
            })
        } else {
            print("no location to fetch for event \(eventID.asString())")
        }
        
        if eventID != ID(type: "z", num: 0) {
            DBUtility.readFromDB(table: FirTable.rsvp, keys: eventID, completion: {(rsvpSnap: DataSnapshot) -> Void in
                thisEvent.rsvps = RSVP(snapshot: rsvpSnap)
                print("event rsvp fetch succeeded: event is \(thisEvent)")
            })
        } else {
            print("no rsvp to fetch for event \(eventID.asString())")
        }
    }
}
