//
//  TeamCalendar.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class TeamCalendar {
    var events: [Event]?
    let ref : DatabaseReference?
    
    init(events: [Event]){
        self.events = events
        ref = nil
    }
    
    init(){
        events = []
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        for event in (snapshot.childSnapshot(forPath: "events").children.allObjects as! [DataSnapshot]) {
            events!.append(Event(key: event.key, snapshot: event))
        }
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        var anyEvents = [Any]()
        if events != nil {
            for event in events! {
                anyEvents.append(event.toAnyObject())
            }
        }
        
        return [
            "events" : anyEvents
        ]
    }
}
