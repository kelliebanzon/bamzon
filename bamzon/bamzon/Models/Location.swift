//
//  Location.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct Location {
    var number: String
    var street: String
    var street2: String?
    var city: String
    var state: String // TODO: change state to be an enum
    var zip: UInt
    var country: String?


    init(number: String, street: String, street2: String?, city: String, state: String, zip: UInt, country: String?){
        self.number = number
        self.street = street
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
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

