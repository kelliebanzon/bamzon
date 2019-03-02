//
//  ViewModel.swift
//  bamzon
//
//  Created by Kevin Krein on 2/21/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import Firebase

class ViewModel {
    
    var user: User?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.user = appDelegate.curUser
        }
    }
}
