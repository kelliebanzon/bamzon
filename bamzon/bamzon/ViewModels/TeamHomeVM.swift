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
    
    func refresh() {
        print("###########################")
        print(team)
        let events = self.team.calendar?.getEvents() ?? []
        let curDate = Date.init(timeIntervalSinceNow: 0)
        for event: Event in events {
            if event.date.compare(curDate).rawValue >= 0 && (nextPractice == nil || nextNonPractice == nil) {
                if nextPractice == nil && event.tags?["practice"] != nil {
                    nextPractice = event
                }
                if nextNonPractice == nil && event.tags?["practice"] != nil {
                    nextNonPractice = event
                }
            }
        }
    }
}
