//
//  CreateAccountParentVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Written by Kyle Vu on 1/27/19
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountParentVC: UIViewController, DisplayableProtocol {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(named: "TSNavy")
        display()
    }
    
    func display() {
        // add container
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
        
        // add child view controller view to container
        let childEmailVC = storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildPromptEmailVC")
        addChildViewController(childEmailVC)
        childEmailVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childEmailVC.view)
        
        NSLayoutConstraint.activate([
            childEmailVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childEmailVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childEmailVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childEmailVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        
        childEmailVC.didMove(toParentViewController: self)
        
        //Some property on ChildVC that needs to be set
        //childVC.dataSource = self
    }

}
