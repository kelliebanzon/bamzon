//
//  JoinTeamVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class JoinTeamParentVC: UIViewController, DisplayableProtocol {
    let joinTeamVM = JoinTeamVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])

        // add child view controller view to container
        let firstChildVC = storyboard!.instantiateViewController(withIdentifier: "JoinTeamChildSelectTeamVC")
        addChildViewController(firstChildVC)
        firstChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(firstChildVC.view)

        NSLayoutConstraint.activate([
            firstChildVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            firstChildVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            firstChildVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            firstChildVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])

        firstChildVC.didMove(toParentViewController: self)
    }
    
    func selectOrganization(org: Organization) {
        // TODO: implement select organization
    }
    
    func selectTeam(teamID: CLong) {
        // TODO: implement select team
    }
    
    func sendJoinRequest(req: JoinRequest) {
        // TODO: implement send join request
    }
}
