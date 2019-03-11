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
        self.user = appDelegate.curUser!
        self.team = appDelegate.curTeam!
    }
}
