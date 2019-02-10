//
//  Event.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct Event {
    var name: String
    var location: Location?
    var contactUserIDs: [ID]?
    var description: String?
    var date: String?
    var rsvps: [RSVP]?
    var tags: [String]?
    var media: [String: Media]?
    var links: [String: URL] // TODO: should this be a url or a string?
    
    init(name: String, location: Location?, contactUserIDs: [ID]?, description: String?, date: String?, rsvps: [RSVP]?, tags: [String]?, media: [String: Media]?, links: [String: URL]){
        self.name = name
        self.location = location
        self.contactUserIDs = contactUserIDs
        self.description = description
        self.date = date
        self.rsvps = rsvps
        self.tags = tags
        self.media = media
        self.links = links
    }
}


