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
        
        // TODO: change these to user names
        let fName = "First"
        let lName = "Last"
        
        let profilePictureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        profilePictureImageView.contentMode = .scaleAspectFill
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.image = UIImage(named: "BZN-Square-Logo")
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.text = fName + "\n" + lName
        
        self.view.addSubview(profilePictureImageView)
        self.view.addSubview(nameLabel)
        
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let profilePictureImageViewTop = NSLayoutConstraint(item: profilePictureImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 100)
        let profilePictureImageViewLeading = NSLayoutConstraint(item: profilePictureImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 100)
        let profilePictureImageViewTrailing = NSLayoutConstraint(item: profilePictureImageView, attribute: .trailing, relatedBy: .equal, toItem: nameLabel, attribute: .trailing, multiplier: 1, constant: 100)
        let profilePictureImageViewBottom = NSLayoutConstraint(item: profilePictureImageView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: view, attribute: .bottom, multiplier: 1, constant: 300)
        NSLayoutConstraint.activate([profilePictureImageViewTop, profilePictureImageViewLeading, profilePictureImageViewTrailing, profilePictureImageViewBottom])
        
        /*nameLabel.translatesAutoresizingMaskIntoConstraints = false
         let nameLabelTop = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 30)
         let nameLabelLeft = NSLayoutConstraint(item: <#T##Any#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)*/
        
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func edit() {
        // TODO: implement edit
    }
}
