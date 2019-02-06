//
//  IDUtility.swift
//  bamzon
//
//  Created by Kellie Banzon on 01/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

class IDUtility {
    
    // TODO: need some variable to keep track of what number ID we're on
    
    static func generateNum() -> UInt {
        // TODO: implement generateNum
        return 0
    }
    
    static func generateUserID() -> ID {
        // TODO: implement generateUserID
        return ID(type: IdType.user, num: 0)
    }
    
    static func generateTeamID() -> ID {
        // TODO: implement generateTeamID
        return ID(type: IdType.team, num: 0)
    }
    
    static func generateOrgID() -> ID {
        // TODO: implement generateOrgID
        return ID(type: IdType.org, num: 0)
    }
    
    static func generateGenericID() -> ID {
        return ID(type: IdType.org, num: 0)
    }
    
    static func generateIDFromString(idString: String) -> ID {
        let type = IdType.init(rawValue: String(idString[0]))
        let num = (UInt)(String(idString[1...idString.count]))
        
        return ID(type: type ?? IdType.other, num: num ?? 0)
    }
    
}

enum IdType: String, Codable {
    case regTeam = "r"
    case user = "u"
    case team = "t"
    case event = "e"
    case org = "o"
    case location = "l"
    case media = "m"
    case other = "z"
}
