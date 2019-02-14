//
//  ProfileVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class ProfileVC: UIViewController, DisplayableProtocol, EditableProtocol, RefreshableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        display()
    }
    
    func display() {
        
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: change these to user names
        let fName = "Jake"
        let lName = "Peralta"
        
        //image view
        let profilePictureImageView = UIImageView()
        
        profilePictureImageView.contentMode = .scaleAspectFill
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.image = UIImage(named: "BZN-Square-Logo")
        profilePictureImageView.layer.cornerRadius = 15.0
        profilePictureImageView.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        
        self.view.addSubview(profilePictureImageView)
        
        //image view constraints
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = profilePictureImageView.topAnchor.constraint(equalTo:
            view.topAnchor, constant: 70)
        let picLeftConstraint = profilePictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let picWidthConstraint = profilePictureImageView.widthAnchor.constraint(equalToConstant: 125)
        let picHeightConstraint = profilePictureImageView.heightAnchor.constraint(equalToConstant: 125)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picWidthConstraint, picHeightConstraint])
        
        //last name
        let lNameLabel = UILabel()
        lNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        lNameLabel.numberOfLines = 1
        lNameLabel.textColor = .white
        lNameLabel.textAlignment = .left
        lNameLabel.text = lName
        lNameLabel.minimumScaleFactor = 0.25
        lNameLabel.adjustsFontSizeToFitWidth = true
        lNameLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(lNameLabel)
        
        //last name constraints
        lNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let lNameBottomConstraint = lNameLabel.bottomAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor)
        let lNameLeftConstraint = lNameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: 20)
        let lNameRightConstraint = view.trailingAnchor.constraint(equalTo: lNameLabel.trailingAnchor, constant: 20)
        
        self.view.addConstraints([lNameBottomConstraint, lNameLeftConstraint, lNameRightConstraint])
        
        //first name
        let fNameLabel = UILabel()
        fNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        fNameLabel.numberOfLines = 1
        fNameLabel.textColor = .white
        fNameLabel.textAlignment = .left
        fNameLabel.text = fName
        fNameLabel.minimumScaleFactor = 0.25
        fNameLabel.adjustsFontSizeToFitWidth = true
        fNameLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(fNameLabel)
        
        //fname constraints
        fNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let fNameBottomConstraint = fNameLabel.bottomAnchor.constraint(equalTo: lNameLabel.topAnchor, constant: -2)
        let fNameLeftConstraint = fNameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: 20)
        let fNameRightConstraint = view.trailingAnchor.constraint(equalTo: fNameLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([fNameBottomConstraint, fNameLeftConstraint, fNameRightConstraint])
        
        //view stats button
        let viewStatsButton = UIButton()
        viewStatsButton.setTitle("View Player Stats", for: .normal)
        viewStatsButton.backgroundColor = UIColor(named: "TSYellow")
        viewStatsButton.layer.shadowColor = UIColor.black.cgColor
        viewStatsButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        viewStatsButton.layer.masksToBounds = false
        viewStatsButton.layer.shadowRadius = 1.0
        viewStatsButton.layer.shadowOpacity = 0.5
        viewStatsButton.layer.cornerRadius = 8
        viewStatsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        
        //viewStatsButton functions
        viewStatsButton.addTarget(self, action: #selector(loadStatsView), for: .touchDown)
        viewStatsButton.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        viewStatsButton.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        self.view.addSubview(viewStatsButton)
        
        //viewStatsButton constraints
        viewStatsButton.translatesAutoresizingMaskIntoConstraints = false
        let viewStatsleftConstraint = viewStatsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let viewStatsRightConstraint = view.trailingAnchor.constraint(equalTo: viewStatsButton.trailingAnchor, constant: 20)
        let viewStatsTopConstraint =
            viewStatsButton.topAnchor.constraint(equalTo: lNameLabel.bottomAnchor, constant: 30)
        let viewStatsHeightConstraint = viewStatsButton.heightAnchor.constraint(equalToConstant: 30)
        
        self.view.addConstraints([viewStatsleftConstraint, viewStatsRightConstraint, viewStatsHeightConstraint, viewStatsTopConstraint])
        
        //biography label
        let bioLabel = UILabel()
        bioLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        bioLabel.numberOfLines = 0
        bioLabel.textColor = .white
        bioLabel.textAlignment = .left
        bioLabel.text = "About Me"
        self.view.addSubview(bioLabel)
        
        //bio label constraints
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        let bioLabelLeftConstraint = bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let bioLabelTopConstraint = bioLabel.topAnchor.constraint(equalTo: viewStatsButton.bottomAnchor, constant: 30)
        self.view.addConstraints([bioLabelLeftConstraint, bioLabelTopConstraint])
 
        //bio text view
        let bio = UITextView()
        bio.textAlignment = .left
        bio.font = UIFont(name: "HelveticaNeue", size: 17)
        bio.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commod"
        bio.textColor = .white
        bio.isEditable = false
        bio.backgroundColor = UIColor(named: "TSTeal")
        adjustUITextViewHeight(arg: bio)
        self.view.addSubview(bio)
        
        //bio constraints
        bio.translatesAutoresizingMaskIntoConstraints = false
        let bioLeftConstraint = bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let bioTopConstraint = bio.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 5)
        let bioRightConstraint = view.trailingAnchor.constraint(equalTo: bio.trailingAnchor, constant: 30)
        view.addConstraints([bioLeftConstraint, bioTopConstraint, bioRightConstraint])
        
        //contact Label
        let contactLabel = UILabel()
        contactLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        contactLabel.numberOfLines = 0
        contactLabel.textColor = .white
        contactLabel.textAlignment = .left
        contactLabel.text = "Contact Information"
        self.view.addSubview(contactLabel)
        
        //contact label constraints
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        let contactLabelLeftConstraint = contactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let contactLabelTopConstraint = contactLabel.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 30)
        self.view.addConstraints([contactLabelLeftConstraint, contactLabelTopConstraint])
        
        //phone Label
        let phoneLabel = UILabel()
        phoneLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        phoneLabel.numberOfLines = 0
        phoneLabel.textColor = .white
        phoneLabel.textAlignment = .left
        phoneLabel.text = "Phone: "
        self.view.addSubview(phoneLabel)
        
        //phone Label constraints
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        let phoneLabelLeftConstraint = phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let phoneLabelTopConstraint = phoneLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 10)
        self.view.addConstraints([phoneLabelLeftConstraint, phoneLabelTopConstraint])
        
        //number Label
        let numberLabel = UILabel()
        numberLabel.font = UIFont(name: "HelveticaNeue", size: 17)
        numberLabel.numberOfLines = 0
        numberLabel.textColor = .white
        numberLabel.textAlignment = .left
        numberLabel.text = "420-666-6969"
        self.view.addSubview(numberLabel)
        
        //phone Label constraints
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        let numberLabelLeftConstraint = numberLabel.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 5)
        let numberLabelBottomConstraint = numberLabel.bottomAnchor.constraint(equalTo: phoneLabel.bottomAnchor)
        self.view.addConstraints([numberLabelLeftConstraint, numberLabelBottomConstraint])
        
        //email Label
        let emailLabel = UILabel()
        emailLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        emailLabel.numberOfLines = 0
        emailLabel.textColor = .white
        emailLabel.textAlignment = .left
        emailLabel.text = "Email: "
        emailLabel.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        self.view.addSubview(emailLabel)
        
        //email Label constraints
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        let emailLabelLeftConstraint = emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let emailLabelTopConstraint = emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5)
        self.view.addConstraints([emailLabelLeftConstraint, emailLabelTopConstraint])
        
        //email text Label
        let emailTextLabel = UILabel()
        emailTextLabel.font = UIFont(name: "HelveticaNeue", size: 17)
        emailTextLabel.numberOfLines = 1
        emailTextLabel.textColor = .white
        emailTextLabel.textAlignment = .left
        emailTextLabel.text = "bryan04@calpoly.edu"
        emailTextLabel.minimumScaleFactor = 0.8
        emailTextLabel.adjustsFontSizeToFitWidth = true
        emailLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(emailTextLabel)
        
        //email text Label constraints
        emailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let emailTextLabelBottomConstraint = emailTextLabel.bottomAnchor.constraint(equalTo: emailLabel.bottomAnchor)
        let emailTextLabelLeftConstraint = emailTextLabel.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 5)
        let emailTextLabelRightConstraint = view.trailingAnchor.constraint(greaterThanOrEqualTo: emailTextLabel.trailingAnchor, constant: 30)
        
        self.view.addConstraints([emailTextLabelLeftConstraint, emailTextLabelBottomConstraint, emailTextLabelRightConstraint])
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
}
