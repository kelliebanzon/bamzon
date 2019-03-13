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
        self.title = "Team Settings"
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        let backButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "arrow-left")))
        self.navigationItem.backBarButtonItem = backButton

        let topLabel = pageLabel(withText: "SPORT?!\rWoah, that's impressive", withFrame: CGRect(x: 0, y: 30, width: 400, height: 120), withCenter: nil)
        self.view.addSubview(topLabel)
        
        // Next Button
        let nextButton = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(checkFields), withCenter: CGPoint(x: view.center.x + 90, y: 450))
        self.view.addSubview(nextButton)
    }
    
    // General function to validate fields
    @objc func checkFields() {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateTeamChildLoadingVC") as? CreateTeamChildLoadingVC
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
}
