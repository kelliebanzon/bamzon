//
//  Event.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//g

import Foundation

struct Event {
    var name: String
    var location: Location?
    var contactUserIDs: [ID]?
    var description: String?
    var date: Date // TODO: should this be a custom date object?
    var rsvps: [RSVP]?
    var tags: [String]?
    var media: [String: Media]?
    var links: [String: URL] // TODO: should this be a url or a string?
    let ref: DatabaseReference?
    
    init(name: String, location: Location?, contactUserIDs: [ID]?, description: String?, date: Date, rsvps: [RSVP]?, tags: [String]?, media: [String: Media]?, links: [String: URL]){
        self.name = name
        self.location = location
        self.contactUserIDs = contactUserIDs
        self.description = description
        self.date = date
        self.rsvps = rsvps
        self.tags = tags
        self.media = media
        self.links = links
        ref = nil
    }
    
    init(){
        name = "N/A"
        date = Date()
        let urlString = "https://pbs.twimg.com/profile_images/986303890487324672/Rxhn6l5C_400x400.jpg"
        let imageURL = URL(string: urlString)!
        links = ["N/A": imageURL]
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        let snapvalues = snapshot.value as! [String: AnyObject]
        name = snapvalues["name"] as? String ?? "N/A"
        location = snapvalues["location"] as? Location ?? Location()
        
        for contactUserID in (snapshot.childSnapshot(forPath:
            "contactUserIDs").children.allObjects as! [DataSnapshot]) {
                contactUserIDs!.append(ID(key: contactUserID.key, snapshot:                                 contactUserID))
        }
        
        description = snapvalues["description"] as? String ?? "N/A"
        date = snapvalues["date"] as? Date ?? Date()
        
        for rsvp in (snapshot.childSnapshot(forPath:
            "rsvps").children.allObjects as! [DataSnapshot]) {
                rsvps!.append(RSVP(key: rsvp.key, snapshot: rsvp))
        }
        
        for tag in (snapshot.childSnapshot(forPath:
            "tags").children.allObjects as! [DataSnapshot]) {
                tags!.append(String(key: tag.key, snapshot: tag))
        }
        
        for med in (snapshot.childSnapshot(forPath: "media").children.allObjects as! [DataSnapshot]) {
            media![med.key] = med.value
        }
        
        let urlString = "https://pbs.twimg.com/profile_images/986303890487324672/Rxhn6l5C_400x400.jpg"
        let imageURL = URL(string: urlString)!
        links = ["N/A": imageURL]
        links = snapvalues["links"] as? [String: URL] ?? ["N/A": imageURL]
        
        for link in (snapshot.childSnapshot(forPath: "links").children.allObjects as! [DataSnapshot]) {
            links![link.key] = link.value
        }
        
        ref = snapshot.ref
        
    }
}
