//
//  Location.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Location: FirebaseCompatable {
    var name: String
    var number: String
    var street: String
    var street2: String?
    var city: String
    var state: String // TODO: change state to be an enum
    var zip: UInt
    var country: String?
    var locID: ID

    init(locID: ID, name: String, number: String, street: String, street2: String?, city: String, state: String, zip: UInt, country: String?) {
        self.locID = locID
        self.name = name
        self.number = number
        self.street = street
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
    }
    
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        locID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        number = payload["number"] as? String ?? "N/A"
        name = payload["name"] as? String ?? "N/A"
        street = payload["street"] as? String ?? "N/A"
        street2 = payload["street2"] as? String ?? nil
        city = payload["city"] as? String ?? "N/A"
        state = payload["state"] as? String ?? "N/A"
        zip = payload["zip"] as? UInt ?? 999
        country = payload["country"] as? String ?? "N/A"
    }
    
    func getTable() -> FirTable {
        return FirTable.location
    }
    
    func getChildPath() -> String {
        return locID.asString()
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["city": city,
             "name": name,
             "country": country ?? "",
             "street": street,
             "street2": street2 ?? "",
             "state": state,
             "zip": zip,
             "number": number
        ]
    }
}

/*class LocationFuncs { // TODO: figure out how to add struct-specific functions
    
    // TODO: verify works Location toString properly
    func toString() -> String {
        var locationString = self.number + " " + self.street
        if let _ = self.street2 {
            locationString += "\n" + self.street2
        }
        locationString += "\n" + self.city + ", " + self.state + " " + self.zip
        if let _ = self.country {
            locationString += "\n" + self.country
        }
        locationString += "\n"
        return locationString
    }
    
}*/
