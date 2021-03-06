//
//  ProfileVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class ProfileVC: UIViewController, DisplayableProtocol, EditableProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedUser: User?
    var profileVM = ProfileVM()
    
    var profilePictureImageView = UIImageView()
    var nameLabel = UILabel()
    var bioLabel = UILabel()
    var bio = UITextView()
    var contactLabel = UILabel()
    var phoneLabel = UILabel()
    var numberLabel = UILabel()
    var emailLabel = UILabel()
    var emailTextLabel = UILabel()

    var showClose: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        display()
    }
    
    func display() {
        
        view.backgroundColor = UIColor(named: "TSTeal")

        if self.showClose {
            showCloseButton()
        }

        // TODO: change these to user name
        if let selectedUser = selectedUser {
            self.selectedUser = selectedUser
        } else {
            self.selectedUser = profileVM.user
        }
        
        profilePictureImageView = ImageUtility().createProfilePictureImageView(imageName: selectedUser!.imageURL, style: .squircle)
        self.view.addSubview(profilePictureImageView)

        nameLabel = createDefaultHeader1Label(text: selectedUser!.getFullName(), numLines: 0)
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.minimumScaleFactor = 0.8
        nameLabel.adjustsFontSizeToFitWidth = false
        self.view.addSubview(nameLabel)
        
        bioLabel = createDefaultHeader2Label(text: "About Me")
        self.view.addSubview(bioLabel)
 
        bio.textAlignment = .left
        bio.font = UIFont(name: "HelveticaNeue", size: 20)
        bio.text = selectedUser!.bio
        bio.textColor = .white
        bio.isEditable = false
        bio.backgroundColor = UIColor(named: "TSTeal")
        adjustUITextViewHeight(arg: bio)
        self.view.addSubview(bio)
        
        contactLabel = createDefaultHeader2Label(text: "Contact Information")
        self.view.addSubview(contactLabel)
        
        phoneLabel = createDefaultBoldLabel(text: "Phone: ")
        self.view.addSubview(phoneLabel)
        
        numberLabel = createDefaultBodyLabel(text: selectedUser!.phone ?? "")
        self.view.addSubview(numberLabel)

        emailLabel = createDefaultBoldLabel(text: "Email: ")
        self.view.addSubview(emailLabel)
        
        emailTextLabel = createDefaultBodyLabel(text: selectedUser!.email ?? "")
        emailTextLabel.minimumScaleFactor = 0.8
        emailTextLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(emailTextLabel)

        setupAutoLayout()
    }

    func showCloseButton() {
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeProfile)), animated: true)
    }

    @objc func closeProfile(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func adjustUITextViewHeight(arg: UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func edit() {
        // TODO: implement edit
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = profilePictureImageView.topAnchor.constraint(equalTo:
            margins.topAnchor, constant: 30)
        let picLeftConstraint = profilePictureImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30)
        let picWidthConstraint = profilePictureImageView.widthAnchor.constraint(equalToConstant: 125)
        let picHeightConstraint = profilePictureImageView.heightAnchor.constraint(equalToConstant: 125)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picWidthConstraint, picHeightConstraint])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profilePictureImageView.centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profilePictureImageView.heightAnchor).isActive = true
        margins.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20).isActive = true

        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        let bioLabelLeftConstraint = bioLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let bioLabelTopConstraint = bioLabel.topAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor, constant: 30)
        self.view.addConstraints([bioLabelLeftConstraint, bioLabelTopConstraint])

        bio.translatesAutoresizingMaskIntoConstraints = false
        let bioLeftConstraint = bio.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30)
        let bioTopConstraint = bio.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 5)
        let bioRightConstraint = margins.trailingAnchor.constraint(equalTo: bio.trailingAnchor, constant: 30)
        self.view.addConstraints([bioLeftConstraint, bioTopConstraint, bioRightConstraint])

        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        let contactLabelLeftConstraint = contactLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let contactLabelTopConstraint = contactLabel.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 30)
        self.view.addConstraints([contactLabelLeftConstraint, contactLabelTopConstraint])
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        let phoneLabelLeftConstraint = phoneLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30)
        let phoneLabelTopConstraint = phoneLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 10)
        self.view.addConstraints([phoneLabelLeftConstraint, phoneLabelTopConstraint])
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        let numberLabelLeftConstraint = numberLabel.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 5)
        let numberLabelVertConstraint = numberLabel.centerYAnchor.constraint(equalTo: phoneLabel.centerYAnchor)
        self.view.addConstraints([numberLabelLeftConstraint, numberLabelVertConstraint])
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        let emailLabelLeftConstraint = emailLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30)
        let emailLabelTopConstraint = emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5)
        self.view.addConstraints([emailLabelLeftConstraint, emailLabelTopConstraint])
        
        emailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let emailTextLabelVertConstraint = emailTextLabel.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor)
        let emailTextLabelLeftConstraint = emailTextLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 5)
        let emailTextLabelRightConstraint = margins.trailingAnchor.constraint(greaterThanOrEqualTo: emailTextLabel.trailingAnchor, constant: 30)
        self.view.addConstraints([emailTextLabelLeftConstraint, emailTextLabelVertConstraint, emailTextLabelRightConstraint])
    }
}
