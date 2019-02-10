//
//  User.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct User {
    var userID: ID
    var firstName: String
    var lastName: String
    var nickname: String?
    var phone: String?
    var email: String?
    var schoolYear: Year?
    var bio: String?
    var imageURL: String? // TODO: should this be a URL?
    var teams: [Team]?
    
    init(userID: ID, firstName: String, lastName: String, nickname: String, phone: String?, email: String?, schoolYear: Year?, bio: String?, imageURL: String?, teams: [Team]?) {
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.schoolYear = schoolYear
        self.bio = bio
        self.imageURL = imageURL
        self.teams = teams
    }
    
}

enum Year: Int {
    case unknown = 0
    case firstYear = 1
    case secondYear = 2
    case thirdYear = 3
    case fourthYear = 4
    case superSenior = 5
    case alumni = 6
    case professor = 7
    /*case firstYear = "First Year"
     case secondYear = "Second Year"
     case thirdYear = "Third Year"
     case fourthYear = "Fourth Year"
     case superSenior = "Super Senior"
     case alumni = "Alumni"
     case professor = "Professor"
     case unknown = "N/A"*/
}
