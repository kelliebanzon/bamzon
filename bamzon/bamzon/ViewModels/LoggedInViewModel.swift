//
//  LoggedInViewModel.swift
//  bamzon
//
//  Created by Kevin Krein on 2/21/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import Firebase

class LoggedInViewModel {
    
    var user: User
    var team: Team
    
    init() {
        // swiftlint:disable force_cast
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
        if appDelegate.curUser == nil {
            self.user = User(userID: IDUtility.generateIDFromString(idString: "u404"), firstName: "Jake", lastName: "Peralta", nickname: nil, phone: "(123) 456-7890", email: "jperal@calpoly.edu", schoolYear: nil, bio: "The best detective in all of Brooklyn!", imageURL: nil, teamIDs: [ID(type: "t", uuid: "404")])
        } else {
            self.user = appDelegate.curUser!
        }
        
        if appDelegate.curTeam == nil {
            self.team = Team(teamID: ID(type: "t", uuid: "404"), orgID: ID(type: "o", uuid: "404"), userIDs: [ID(type: "u", uuid: "404")], teamName: "Test Team", sport: "Cricket", stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)
        } else {
            self.team = appDelegate.curTeam!
        }
    }
}
