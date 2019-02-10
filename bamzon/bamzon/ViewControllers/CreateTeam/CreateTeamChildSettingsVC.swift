//
//  CreateTeamChildSettingsVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/09/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class CreateTeamChildSettingsVC: UIViewController, DisplayableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        // TODO: display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: temporary identifier code. delete this once you write the real display func
        
        // Temp Label
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 420))
        tempLabel.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        tempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 0
        tempLabel.textColor = .white
        tempLabel.text = "CreateTeamChildSettingsVC"
        self.view.addSubview(tempLabel)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
