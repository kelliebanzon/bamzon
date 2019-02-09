//
//  CalendarVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class CalendarVC: UIViewController, DisplayableProtocol, EditableProtocol, RefreshableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        display()
        // Do any additional setup after loading the view, typically from a nib.
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
        tempLabel.text = "CalendarVC"
        self.view.addSubview(tempLabel)
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func edit() {
        // TODO: implement edit
    }
    
    func changeView(view: String) {
        // TODO: implement change view
    }
    
    func filter(tags: [String]) {
        // TODO: implement filter
    }
    
    func selectDay(day: Date) {
        // TODO: implement select day
    }
    
    func selectEvent(event: Event) {
        // TODO: implement select event
    }
    
    func addEvent(event: Event) {
        // TODO: implement add event
    }
    
    func notify(message: String) {
        // TODO: implement notify
    }
}
