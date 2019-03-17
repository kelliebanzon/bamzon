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
        return ID(type: IDType.user.rawValue, uuid: UUID().uuidString)
    }
    
    static func generateTeamID() -> ID {
        // TODO: implement generateTeamID
        return ID(type: IDType.team.rawValue, uuid: UUID().uuidString)
    }
    
    static func generateOrgID() -> ID {
        // TODO: implement generateOrgID
        return ID(type: IDType.org.rawValue, uuid: UUID().uuidString)
    }

    static func generateEventID() -> ID {
        // TODO: implement generateEventID
        return ID(type: IDType.event.rawValue, uuid: UUID().uuidString)
    }

    static func generateLocationID() -> ID {
        // TODO: implement generateLocationID
        return ID(type: IDType.location.rawValue, uuid: UUID().uuidString)
    }
    
    static func generateGenericID() -> ID {
        return ID(type: IDType.org.rawValue, uuid: UUID().uuidString)
    }
    
    static func generateIDFromString(idString: String) -> ID {
        let type = IDType.init(rawValue: String(idString.prefix(1)))
        let uuid = String(idString.suffix(idString.count-1))
        
        return ID(type: type?.rawValue ?? IDType.other.rawValue, uuid: uuid)
    }
    
    // these two might be better elsewhere
    static func idsToStrings(ids: [ID]) -> [String] {
        var stringArr = [String]()
        ids.forEach { nextID in
            stringArr.append(nextID.toString())
        }
        return stringArr
    }
    
    static func idsToDict(ids: [ID: ID]) -> [String: String] {
        var stringDict = [String: String]()
        ids.forEach { nextID in
            stringDict[nextID.key.toString()] = nextID.key.toString()
        }
        return stringDict
    }
    
    static func stringsToIDs(strs: [String]) -> [ID] {
        var idArr = [ID]()
        strs.forEach { str in
            idArr.append(generateIDFromString(idString: str))
        }
        return idArr
    }
    
    static func stringsToIDDict(strs: [String: String]) -> [ID: ID] {
        var idArr = [ID :ID]()
        strs.forEach { str in
            let str = generateIDFromString(idString: str.key)
            idArr[str] =  str
        }
        return idArr
    }
    
    static func stringsToStringIDDict(strs: [String: String]) -> [String: ID] {
        var idArr = [String :ID]()
        strs.forEach { str in
            let id = generateIDFromString(idString: str.key)
            idArr[str.key] =  id
        }
        return idArr
    }
    
}

enum IDType: String, Codable {
    case regTeam = "r"
    case user = "u"
    case team = "t"
    case event = "e"
    case org = "o"
    case joinReq = "j"
    case location = "l"
    case media = "m"
    case other = "z"
}
