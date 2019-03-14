//
//  JoinTeamChildRequestSentVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/21/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class JoinTeamChildRequestSentVC: UIViewController, DisplayableProtocol {

    var reqSentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        navigationItem.setRightBarButton(UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closeJoinTeamVC)), animated: true)
                
        reqSentLabel = createDefaultHeader2Label(text: "A join request has been sent! An admin will approve or deny your request.", numLines: 0, fontAlignment: .center)
        reqSentLabel.lineBreakMode = .byWordWrapping
        reqSentLabel.adjustsFontSizeToFitWidth = false
        self.view.addSubview(reqSentLabel)

        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        reqSentLabel.translatesAutoresizingMaskIntoConstraints = false
        let reqSentVert = reqSentLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        let reqSentLeading = reqSentLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let reqSentTrailing = margins.trailingAnchor.constraint(equalTo: reqSentLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([reqSentVert, reqSentLeading, reqSentTrailing])
    }

    @objc func closeJoinTeamVC() {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
}
