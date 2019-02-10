//
//  RSVP.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct RSVP {
    var yesUserIDs: [ID]?
    var noUserIDs: [ID]?
    var pendingUserIDs: [ID]?
    
    init(yesUserIDs: [ID]?, noUserIDs: [ID]?, pendingUserIDs: [ID]?){
        self.yesUserIDs = yesUserIDs
        self.noUserIDs = noUserIDs
        self.pendingUserIDs = pendingUserIDs
    }
}
