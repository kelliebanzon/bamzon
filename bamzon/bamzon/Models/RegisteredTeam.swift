//
//  RegisteredTeam.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct RegisteredTeam {
    var regID: UInt
    var teamID: UInt
    var stats: [UInt: PlayerStats]?
    var permissions: [UInt: Permissions]?
}
