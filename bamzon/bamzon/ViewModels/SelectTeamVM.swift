//
//  SelectTeamVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

//List of teams for user

class SelectTeamVM: ViewModel {
    func refresh() {
        //TODO: implement refresh teams to select
    }
    
    func select(selectedTeam: Team) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.curTeam = selectedTeam
        }
    }
    
}
