//
//  User.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class User {
    var userID: ID
    var firstName: String
    var lastName: String
    var nickname: String?
    var phone: String?
    var email: String?
    var year: Year?
    var bio: String?
    var imageURL: URL? // TODO: should this be a URL?
    var picture: UIImage?
    var teams: [RegisteredTeam]?
    let ref: DatabaseReference?
    
    init(userID: ID, firstName: String, lastName: String, nickname: String, phone: String?, email: String?, year: Year?, bio: String?, imageURL: URL?, picture: UIImage?, teams: [RegisteredTeam]?) {
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
        self.phone = phone
        self.email = email
        self.year = year
        self.bio = bio
        self.imageURL = imageURL
        self.picture = picture
        self.teams = teams
        ref = nil
        
    }
    
    init(){
        userID = ID(type: IdType.user, num: 0)
        firstName = "N/A"
        lastName = "N/A"
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        
        let snapvalues = snapshot.value as! [String : AnyObject]
        userID = snapvalues["userID"] as? ID ?? ID(type: IdType.user, num: 0)
        firstName = snapvalues["firstName"] as? String ?? "N/A"
        lastName = snapvalues["lastName"] as? String ?? "N/A"
        //picture = snapvalues["picture"] as? UIImage ?? UIImage(named: "kyle.jpeg")
        phone = snapvalues["phone"] as? String ?? "N/A"
        email = snapvalues["email"] as? String ?? "N/A"
        year = (snapvalues["year"] as? Int).map { Year(rawValue: $0) } ?? Year.unknown
        bio = snapvalues["bio"] as? String ?? "N/A"
        let urlString = snapvalues["url"] as? String ?? "https://pbs.twimg.com/profile_images/986303890487324672/Rxhn6l5C_400x400.jpg"
        imageURL = URL(string: urlString)!
        
        for team in (snapshot.childSnapshot(forPath: "registeredTeams").children.allObjects as! [DataSnapshot]) {
            teams!.append(RegisteredTeam(key: team.key, snapshot: team))
        }
        
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        return [
            "firstName" : firstName,
            "lastName" : lastName,
            "year" : year?.rawValue,
            "bio" : bio,
            "imageURL" : imageURL?.absoluteString
        ]
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



