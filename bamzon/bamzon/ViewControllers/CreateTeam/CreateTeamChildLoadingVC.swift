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
    var loadingLabelText = "Setting up your team"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        animatePeriods()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        loadingLabel = createDefaultHeader2Label(text: loadingLabelText, numLines: 0)
        loadingLabel.textAlignment = .center
        self.view.addSubview(loadingLabel)

        setupAutoLayout()
    }

    func animatePeriods() {
        let maxDelay = 3
        for delaySeconds in 0...maxDelay {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(delaySeconds)) {
                self.loadingLabelText += "."
                self.display()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(maxDelay)) {
            self.loadingLabelText += "\nDone"
            self.display()
            self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.closeCreateTeamVC)), animated: true)
        }
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        let loadingVert = loadingLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 45)
        let loadingHoriz = loadingLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 160)
        self.view.addConstraints([loadingVert, loadingHoriz])
    }

    @objc func closeCreateTeamVC() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
