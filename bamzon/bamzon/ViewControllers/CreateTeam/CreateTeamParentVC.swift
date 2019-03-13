//
//  CreateTeamParentVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class CreateTeamParentVC: UIViewController, DisplayableProtocol {

    var createTeamVM = CreateTeamVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }

    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
    }
}
