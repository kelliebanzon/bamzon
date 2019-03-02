//
//  PlayerStatsVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

class PlayerStatsVM: ViewModel {
    var playerStats: PlayerStats?
    
    func refresh(playerStatsVC: DisplayableProtocol) {
        if self.user != nil {
            DBUtility.readFromDB(table: FirTable.playerStats, keys: self.user!.userID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                self.playerStats = PlayerStats(key: key, payload: payload)
                playerStatsVC.display()
            })
        }
    }
}
