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

    var containerView = UIView()
    var childVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Create a Team"
        display()
    }

    // TODO: @KELLIE TURN THIS INTO A NAV CONTROLLER
    func display() {
        view.backgroundColor = UIColor(named: "TSOrange")
//        navigationItem.setHidesBackButton(false, animated: false)
//        self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController?.navigationBar.isTranslucent = true
//        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "arrow-left"), style: .plain, target: self, action: nil), animated: true)
//        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: nil), animated: true)
//        print(navigationItem)
//        print(self.navigationController?.isNavigationBarHidden)

        view.addSubview(containerView)

        let childVC = storyboard!.instantiateViewController(withIdentifier: "CreateTeamChildNameVC")
//        self.addChildViewController(childVC)
        containerView.addSubview(childVC.view)

//        childVC.didMove(toParentViewController: self)

    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            margins.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            margins.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])

//        childVC.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: childVC.view.trailingAnchor),
//            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
//            containerView.bottomAnchor.constraint(equalTo: childVC.view.bottomAnchor)
//            ])

    }
}
