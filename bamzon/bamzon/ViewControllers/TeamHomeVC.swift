//
//  TeamHomeVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class TeamHomeVC: UIViewController, DisplayableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Home"
        display()
    }
    
    func display() {
        // TODO: implement display
        
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 120))
        tempLabel.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        tempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 1
        tempLabel.textColor = .white
        tempLabel.text = "TeamHomeVC"
        self.view.addSubview(tempLabel)
    }
    
    func viewStats() {
        // TODO: implement view stats
    }
    
    func viewRoster() {
        // TODO: implement view roster
    }
    
    func viewCalendar() {
        // TODO: implement view calendar
    }
    
    func viewAttendance() {
        // TODO: implement view attendance
    }
    
    func viewSettings() {
        // TODO: implement view settings
    }
}
