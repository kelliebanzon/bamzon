//
//  RegisteredTeam.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct RegisteredTeam {
    var regID: ID
    var teamID: ID
    var stats: [ID: PlayerStats]?
    var permissions: [ID: Permissions]?
}
