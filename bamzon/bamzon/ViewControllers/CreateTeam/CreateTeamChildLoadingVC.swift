//
//  CreateTeamChildLoadingVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/09/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class CreateTeamChildLoadingVC: UIViewController, DisplayableProtocol {

    var loadingLabel = UILabel()
    var loadingLabelText = "Your team has been created."
        
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        navigationItem.hidesBackButton = true
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeCreateTeamVC)), animated: true)
        
        loadingLabel = createDefaultHeader2Label(text: loadingLabelText, numLines: 0, fontAlignment: .center)
        loadingLabel.lineBreakMode = .byWordWrapping
        self.view.addSubview(loadingLabel)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        let loadingLeading = loadingLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let loadingTrailing = loadingLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20)
        let loadingVert = loadingLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        self.view.addConstraints([loadingLeading, loadingTrailing, loadingVert])
    }

    @objc func closeCreateTeamVC() {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
}
