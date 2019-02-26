//
//  StatsVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class StatsParentVC: UIViewController, DisplayableProtocol, EditableProtocol, RefreshableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stats"
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

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
        let childVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StatsTabVC")
        addChildViewController(childVC)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childVC.view)

        NSLayoutConstraint.activate([
            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100),
            childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])

        childVC.didMove(toParentViewController: self)
        
    }

    // TODO: these functions no longer belong in this file
    func refresh() {
        // TODO: implement refresh
    }
    
    func edit() {
        // TODO: implement edit stats
    }
    
    func viewPlayerStats(playerID: CLong) {
        // TODO: implement view player stats
    }
}
