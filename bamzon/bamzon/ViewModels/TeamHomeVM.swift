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
        for event in events {
            if (nextPractice == nil && event.tags["practice"] != nil) {
                nextPractice = event
            }
            if (nextNonPractice == nil && event.tags["practice"] == nil) {
                nextNonPractice = event
            }
        }
    }
}
