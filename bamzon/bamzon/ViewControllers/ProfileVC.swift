//
//  ProfileVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class ProfileVC: UIViewController, DisplayableProtocol, EditableProtocol, RefreshableProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let profileVM = ProfileVM()
    var user: User?
    
    var profilePictureImageView = UIImageView()
    var lNameLabel = UILabel()
    var fNameLabel = UILabel()
    var viewStatsButton = UIButton()
    var bioLabel = UILabel()
    var bio = UITextView()
    var contactLabel = UILabel()
    var phoneLabel = UILabel()
    var numberLabel = UILabel()
    var emailLabel = UILabel()
    var emailTextLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        display()
        setupAutoLayout()
    }
    
    func display() {
        
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: change these to user name
        
        //image view
        profilePictureImageView.contentMode = .scaleAspectFill
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.image = UIImage(named: "default-profile-picture")
        profilePictureImageView.layer.cornerRadius = 15.0; profilePictureImageView.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        self.view.addSubview(profilePictureImageView)
        
        //last name
        lNameLabel = createDefaultLabel(text: "", fontSize: 30, numLines: 1, fontColor: .white, fontAlignment: .left)
        lNameLabel.text = profileVM.user.lastName
        lNameLabel.minimumScaleFactor = 0.25
        lNameLabel.adjustsFontSizeToFitWidth = true
        lNameLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(lNameLabel)
        
        //first name
        
        fNameLabel = createDefaultLabel(text: profileVM.user.firstName, fontSize: 30, numLines: 1, fontColor: .white, fontAlignment: .left)
        fNameLabel.minimumScaleFactor = 0.25
        fNameLabel.adjustsFontSizeToFitWidth = true
        fNameLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(fNameLabel)
        
        //view stats button
        viewStatsButton = createButtonToConstrain(withText: "View Player Stats", size: 15)
        
        //viewStatsButton functions
        viewStatsButton.addTarget(self, action: #selector(loadStatsView), for: .touchDown)
        viewStatsButton.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        viewStatsButton.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        self.view.addSubview(viewStatsButton)

        //biography label
        bioLabel = createDefaultLabel(text: "About Me", fontSize: 25, numLines: 0, fontColor: .white, fontAlignment: .left)
        self.view.addSubview(bioLabel)
 
        //bio text view
        bio.textAlignment = .left
        bio.font = UIFont(name: "HelveticaNeue", size: 17)
        bio.text = profileVM.user.bio
        bio.textColor = .white
        bio.isEditable = false
        bio.backgroundColor = UIColor(named: "TSTeal")
        adjustUITextViewHeight(arg: bio)
        self.view.addSubview(bio)
        
        //contact Label
        contactLabel = createDefaultLabel(text: "Contact Information", fontSize: 25, numLines: 0, fontColor: .white, fontAlignment: .left)
        self.view.addSubview(contactLabel)
        
        //phone Label
        phoneLabel = createDefaultLabel(text: "Phone: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        self.view.addSubview(phoneLabel)
        
        //number Label
        numberLabel = createDefaultLabel(text: "", fontSize: 0, numLines: 0, fontColor: .white, fontAlignment: .left)
        numberLabel.font = UIFont(name: "HelveticaNeue", size: 17)
        numberLabel.text = profileVM.user.phone
        self.view.addSubview(numberLabel)

        //email Label
        emailLabel = createDefaultLabel(text: "Email: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        emailLabel.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        self.view.addSubview(emailLabel)
        
        //email text Label
        emailTextLabel = createDefaultLabel(text: "", fontSize: 0, numLines: 1, fontColor: .white, fontAlignment: .left)
        emailTextLabel.font = UIFont(name: "HelveticaNeue", size: 17)
        emailTextLabel.text = profileVM.user.email
        emailTextLabel.minimumScaleFactor = 0.8
        emailTextLabel.adjustsFontSizeToFitWidth = true
        emailLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(emailTextLabel)
    }
    
    func adjustUITextViewHeight(arg: UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func edit() {
        // TODO: implement edit
    }
    
    @objc func loadStatsView() {
        // TODO: implement switch to stats view
    }
    
    func setupAutoLayout() {
        //image view constraints
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = profilePictureImageView.topAnchor.constraint(equalTo:
            view.topAnchor, constant: 70)
        let picLeftConstraint = profilePictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let picWidthConstraint = profilePictureImageView.widthAnchor.constraint(equalToConstant: 125)
        let picHeightConstraint = profilePictureImageView.heightAnchor.constraint(equalToConstant: 125)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picWidthConstraint, picHeightConstraint])

        //last name constraints
        lNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let lNameBottomConstraint = lNameLabel.bottomAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor)
        let lNameLeftConstraint = lNameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: 20)
        let lNameRightConstraint = view.trailingAnchor.constraint(equalTo: lNameLabel.trailingAnchor, constant: 20)
        
        self.view.addConstraints([lNameBottomConstraint, lNameLeftConstraint, lNameRightConstraint])

        //fname constraints
        fNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let fNameBottomConstraint = fNameLabel.bottomAnchor.constraint(equalTo: lNameLabel.topAnchor, constant: -2)
        let fNameLeftConstraint = fNameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: 20)
        let fNameRightConstraint = view.trailingAnchor.constraint(equalTo: fNameLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([fNameBottomConstraint, fNameLeftConstraint, fNameRightConstraint])
        
        //viewStatsButton constraints
        viewStatsButton.translatesAutoresizingMaskIntoConstraints = false
        let viewStatsleftConstraint = viewStatsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let viewStatsRightConstraint = view.trailingAnchor.constraint(equalTo: viewStatsButton.trailingAnchor, constant: 20)
        let viewStatsTopConstraint =
            viewStatsButton.topAnchor.constraint(equalTo: lNameLabel.bottomAnchor, constant: 30)
        let viewStatsHeightConstraint = viewStatsButton.heightAnchor.constraint(equalToConstant: 30)
        
        self.view.addConstraints([viewStatsleftConstraint, viewStatsRightConstraint, viewStatsHeightConstraint, viewStatsTopConstraint])
        
        //bio label constraints
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        let bioLabelLeftConstraint = bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let bioLabelTopConstraint = bioLabel.topAnchor.constraint(equalTo: viewStatsButton.bottomAnchor, constant: 30)
        self.view.addConstraints([bioLabelLeftConstraint, bioLabelTopConstraint])

        //bio constraints
        bio.translatesAutoresizingMaskIntoConstraints = false
        let bioLeftConstraint = bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let bioTopConstraint = bio.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 5)
        let bioRightConstraint = view.trailingAnchor.constraint(equalTo: bio.trailingAnchor, constant: 30)
        view.addConstraints([bioLeftConstraint, bioTopConstraint, bioRightConstraint])

        //contact label constraints
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        let contactLabelLeftConstraint = contactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let contactLabelTopConstraint = contactLabel.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 30)
        self.view.addConstraints([contactLabelLeftConstraint, contactLabelTopConstraint])
        
        //phone Label constraints
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        let phoneLabelLeftConstraint = phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let phoneLabelTopConstraint = phoneLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 10)
        self.view.addConstraints([phoneLabelLeftConstraint, phoneLabelTopConstraint])
        
        //phone Label constraints
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        let numberLabelLeftConstraint = numberLabel.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 5)
        let numberLabelBottomConstraint = numberLabel.bottomAnchor.constraint(equalTo: phoneLabel.bottomAnchor)
        self.view.addConstraints([numberLabelLeftConstraint, numberLabelBottomConstraint])
        
        //email Label constraints
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        let emailLabelLeftConstraint = emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let emailLabelTopConstraint = emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5)
        self.view.addConstraints([emailLabelLeftConstraint, emailLabelTopConstraint])
        
        //email text Label constraints
        emailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let emailTextLabelBottomConstraint = emailTextLabel.bottomAnchor.constraint(equalTo: emailLabel.bottomAnchor)
        let emailTextLabelLeftConstraint = emailTextLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 5)
        let emailTextLabelRightConstraint = view.trailingAnchor.constraint(greaterThanOrEqualTo: emailTextLabel.trailingAnchor, constant: 30)
        self.view.addConstraints([emailTextLabelLeftConstraint, emailTextLabelBottomConstraint, emailTextLabelRightConstraint])
    }
}
