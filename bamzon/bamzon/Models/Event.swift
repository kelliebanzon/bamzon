//
//  Event.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Event: FirebaseCompatable, Equatable, Comparable {
    var name: String
    var locationID: ID?
    var contactUserIDs: [ID]?
    var description: String?
    var date: Date
    var tags: [String: String]?
    var media: [String: ID]?
    var links: [String: String]? // TODO: should this be a url or a string?
    var eventID: ID
    var teamID: ID
    
    init(eventID: ID, teamID: ID, name: String, locationID: ID?, contactUserIDs: [ID]?, description: String?, date: Date?, tags: [String: String]?, media: [String: ID]?, links: [String: String]?) {
        self.name = name
        self.locationID = locationID ?? IDUtility.generateIDFromString(idString: "z0")
        self.contactUserIDs = contactUserIDs
        self.description = description
        self.date = date ?? Date.init(timeIntervalSince1970: 0) // default date is 1970
        self.tags = tags
        self.media = media
        self.links = links
        self.eventID = eventID
        self.teamID = teamID
    }
    
    func formatForDB() -> [String: Any] {
        var mediaConverted: [String: String] = [:]
        for med in media ?? [:] {
            mediaConverted[med.key] = med.value.toString()
        }
        return
            ["name": name,
             "teamID": teamID.toString(),
             "location": locationID?.toString() ?? "",
             "contactUserIDs": IDUtility.idsToStrings(ids: contactUserIDs),
             "description": description ?? "",
             "date": date.toString(),
             "tags": tags ?? [:],
             "media": mediaConverted,
             "links": links ?? [:]]
    }
    
    func getTable() -> FirTable {
        return FirTable.event
    }
    
    func getChildPath() -> String {
        return "\(eventID.toString())"
    }
    
    init(key: String, payload: [String: AnyObject]) {
        eventID = IDUtility.generateIDFromString(idString: key)
        name = payload["name"] as? String ?? "N/A"
        locationID = IDUtility.generateIDFromString(idString: payload["location"] as? String ?? "z0")
        contactUserIDs = IDUtility.stringsToIDs(strs: payload["contactUserIDs"] as? [String] ?? [])
        description = payload["description"] as? String ?? "N/A"
        date = Date.fromString(from: payload["date"] as? String ?? "1920-01-01 00:00 -0000")
        tags = payload["tags"] as? [String: String] ?? [:]
        let mediaDict = payload["media"] as? [String: String] ?? [:]
        if !mediaDict.isEmpty {
            media = [:]
        }
        for med in mediaDict {
            media?.updateValue(IDUtility.generateIDFromString(idString: med.value), forKey: med.key)
        }
        links = payload["links"] as? [String: String] ?? [:]
        teamID = IDUtility.generateIDFromString(idString: payload["teamID"] as? String ?? "z0")
    }
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        if lhs.date == Date.init(timeIntervalSince1970: 0) {
            return false
        }
        if rhs.date == Date.init(timeIntervalSince1970: 0) {
            return true
        }
        return lhs.date < rhs.date
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.locationID == rhs.locationID &&
            lhs.contactUserIDs == rhs.contactUserIDs &&
            lhs.description == rhs.description &&
            lhs.date == rhs.date &&
            lhs.tags == rhs.tags &&
            lhs.links == rhs.links &&
            lhs.eventID == rhs.eventID &&
            lhs.teamID == rhs.teamID &&
            lhs.media == rhs.media
    }
    
}
