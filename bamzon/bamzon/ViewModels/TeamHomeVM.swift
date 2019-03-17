//
//  TeamHomeVM.swift
//  bamzon
//
//  Created by liblabs-mac on 3/13/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
//event objects

class TeamHomeVM: LoggedInViewModel {
    
    var nextPractice: Event?
    var nextNonPractice: Event?
    
    func refresh(dispatch: DispatchGroup) {
        events.sort() // sorts by date
        for event in events {
            if  isNextPractice(event: event) {
                nextPractice = event
            }
            if  isNextNonPractice(event: event) {
                nextNonPractice = event
            }
        }
    }
    
    func isNextPractice(event: Event) -> Bool {
        let currentDate = Date.init(timeIntervalSinceNow: 0)
        return nextPractice == nil && event.tags["practice"] != nil && event.date >= currentDate
    }
    
    func isNextNonPractice(event: Event) -> Bool {
        let currentDate = Date.init(timeIntervalSinceNow: 0)
        return nextNonPractice == nil && event.tags["practice"] == nil && event.date >= currentDate
    }
}
