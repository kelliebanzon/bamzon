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
    var contactUserIDs: [UInt]?
    var description: String?
    var date: Date // TODO: should this be a custom date object?
    var rsvps: [RSVP]?
    var tags: [String]?
    var media: [String: Media]?
    var links: [String: URL] // TODO: should this be a url or a string?
}
