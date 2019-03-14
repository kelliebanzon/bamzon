//
//  CreateAccountChildSuccessVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/07/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateAccountChildSuccessVC: UIViewController, DisplayableProtocol {

    var name: String?
    var successLabel = UILabel()
    var closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        closeButton = createCloseButton(action: #selector(goToLogin))
        self.view.addSubview(closeButton)

        successLabel = createDefaultHeader2Label(text: createGreetingMessage(name: name), numLines: 0, fontAlignment: .center)
        successLabel.lineBreakMode = .byWordWrapping
        self.view.addSubview(successLabel)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let closeTrailing = margins.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 30)
        let closeTop = closeButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 30)
        let closeHeight = closeButton.heightAnchor.constraint(equalToConstant: 24)
        let closeAspect = closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        self.view.addConstraints([closeTrailing, closeTop, closeHeight, closeAspect])

        successLabel.translatesAutoresizingMaskIntoConstraints = false
        let successVert = successLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        let successLeading = successLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let successTrailing = successLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20)
        self.view.addConstraints([successVert, successLeading, successTrailing])
    }

    func createGreetingMessage(name: String?) -> String {
        let beginning = "Welcome to TeamSync"
        let end = "! Let's get started."
        var final = beginning
        if let name = name {
            final += ", " + name
        }
        return final + end
    }

    @objc func goToLogin(sender: UIButton) {
        print("goToLogin")
        self.setRootView(toVC: "LoginVC")
    }

}
