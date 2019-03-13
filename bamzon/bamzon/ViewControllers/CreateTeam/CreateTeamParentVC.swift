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

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }

    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        let backButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "arrow-left")))
        self.navigationItem.backBarButtonItem = backButton

        let firstChildVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateTeamChildNameVC")
        let navController = createDefaultNavigationController(rootViewController: firstChildVC)
        self.present(navController, animated: false, completion: nil)

//        view.addSubview(containerView)

        // add child view controller view to container
//        addChildViewController(firstChildVC)
//        firstChildVC.view.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(firstChildVC.view)
//
//        NSLayoutConstraint.activate([
//            firstChildVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            firstChildVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            firstChildVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
//            firstChildVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//            ])
//
//        firstChildVC.didMove(toParentViewController: self)

//        setupAutoLayout()
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

    }
}
