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
        
        let topLabel = pageLabel(withText: "SPORT?!\rWoah, that's impressive", withFrame: CGRect(x: 0, y: 30, width: 400, height: 120), withCenter: nil)
        self.view.addSubview(topLabel)
        
        // Next Button
        let nextButton = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(checkFields), withCenter: CGPoint(x: view.center.x + 90, y: 450))
        self.view.addSubview(nextButton)
        
        // Back Button
        let backButton = createDefaultButton(withText: "Back", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(goBack), withCenter: CGPoint(x: view.center.x - 90, y: 450))
        self.view.addSubview(backButton)
    }
    
    // General function to validate fields
    @objc func checkFields() {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateTeamChildLoadingVC") as? CreateTeamChildLoadingVC
        
        self.mockSegue(toVC: nextVC!)
    }
    
    @objc func goBack() {
        alert(withTitle: "⚠️ WORK IN PROGRESS ⚠️", withMessage: "Back button to be implemented...")
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
