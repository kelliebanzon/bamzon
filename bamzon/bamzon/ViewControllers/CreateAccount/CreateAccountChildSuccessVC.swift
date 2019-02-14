//
//  CreateAccountChildSuccessVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/07/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateAccountChildSuccessVC: UIViewController, DisplayableProtocol {

    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        // TODO: display
        view.backgroundColor = UIColor(named: "TSTeal")
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        let tempLabel = pageLabel(withText: name! + " \rwhat a great name!\rLet's get started.", withFrame: CGRect(x: 0, y: 0, width: 300, height: 420), withCenter: CGPoint(x: view.frame.midX, y: view.frame.midY))
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
