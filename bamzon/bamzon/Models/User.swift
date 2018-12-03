//
//  User.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct User {
    var userID: UInt
    var firstName: String
    var lastName: String
    var nickname: String?
    var phone: String?
    var email: String?
    var schoolYear: Int?
    var bio: String?
    var imageURL: String? // TODO: should this be a URL?
    var teams: [RegisteredTeam]?
}
