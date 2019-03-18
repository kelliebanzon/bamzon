//
//  User.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct User: FirebaseCompatable, Equatable, Comparable {
    var userID: ID
    var firstName: String
    var lastName: String
    var nickname: String?
    var phone: String?
    var email: String?
    var schoolYear: Year?
    var bio: String?
    var imageURL: String? // TODO: should this be a URL?
    var teamIDs: [ID: ID]
    
    init(userID: ID, firstName: String, lastName: String, nickname: String?, phone: String?, email: String?, schoolYear: Year?, bio: String?, imageURL: String?, teamIDs: [ID: ID]) {
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.nickname = nickname
        self.phone = phone
        self.email = email
        self.schoolYear = schoolYear
        self.bio = bio
        self.imageURL = imageURL
        self.teamIDs = teamIDs
    }
    
    init(key: String, payload: [String: AnyObject]) {
        userID = IDUtility.generateIDFromString(idString: key)
        firstName = payload["firstName"] as? String ?? "N/A"
        lastName = payload["lastName"] as? String ?? "N/A"
        nickname = payload["nickname"] as? String ?? "N/A"
        phone = payload["phone"] as? String ?? "N/A"
        email = payload["email"] as? String ?? "N/A"
        schoolYear = Year(rawValue: payload["schoolYear"] as? Int ?? 0)
        bio = payload["bio"] as? String ?? "N/A"
        imageURL = payload["imageURL"] as? String ?? "N/A"
        teamIDs = IDUtility.stringsToIDDict(strs: payload["teamIDs"] as? [String: String] ?? [:])
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.getFullName() < rhs.getFullName()
    }
    
    
    func formatForDB() -> [String: Any] {
        return
            ["firstName": firstName,
             "lastName": lastName,
             "nickname": nickname ?? "",
             "phone": phone ?? "",
             "email": email ?? "",
             "schoolYear": schoolYear?.rawValue ?? "",
             "bio": bio ?? "",
             "imageURL": imageURL ?? "",
             "teamIDs": IDUtility.idsToDict(ids: teamIDs)]
    }
    
    func getTable() -> FirTable {
        return FirTable.user
    }
    
    func getChildPath() -> String {
        return userID.toString()
    }

    func getFullName() -> String {
        return (nickname ?? firstName) + " " + lastName
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
