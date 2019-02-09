//
//  FirebaseAdaptProtocol.swift
//  bamzon
//
//  Created by Daniel Heyde on 2/7/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import Firebase

protocol FirebaseCompatable {
    // writes object to db reference
    func formatForDB() -> [String: Any]
    func getTable() -> String
    func getChildPath() -> String
    init (snapshot: DataSnapshot?)
}
