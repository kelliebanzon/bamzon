//
//  AttendanceParentVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class AttendanceParentVC: UIViewController, DisplayableProtocol, EditableProtocol, RefreshableProtocol {

    let containerView = UIView()
    let childVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AttendanceTabVC")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Attendance"
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        view.addSubview(containerView)

        addChildViewController(childVC)
        containerView.addSubview(childVC.view)

        childVC.didMove(toParentViewController: self)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: margins.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])

        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func edit() {
        // TODO: implement edit
    }
    
    func viewPlayer(playerID: CLong) {
        // TODO: implement view player
    }
}
