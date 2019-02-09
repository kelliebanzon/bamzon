//
//  SelectTeamVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class SelectTeamVC: UIViewController, DisplayableProtocol, RefreshableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display()
    }
    
    func display() {
        // TODO: implement display
        
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 120))
        tempLabel.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        tempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 1
        tempLabel.textColor = .white
        tempLabel.text = "SelectTeamVC"
        self.view.addSubview(tempLabel)
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func createTeam() {
    // TODO: implement create team
    }
    
    func joinTeam() {
    // TODO: implement join team
    }
    
    func viewTeam(regID: CLong) {
    // TODO: implement view team
    }
    
    func logout() {
    // TODO: implement logout
    }
}
