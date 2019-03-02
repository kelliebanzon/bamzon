//
//  ProfileVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class ProfileVM: ViewModel {
    
    func editProfilePic(parentVC: ProfileVC, imagePicker: UIImagePickerController) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            imagePicker.delegate = parentVC
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            parentVC.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getProfileImage() {
//        let data = UIImagePNGRepresentation(user.imageURL) as NSData?
//        let imageName = sourceVC.passedAthlete.name + ".png"
//        profilePicsRef.child(imageName).putData(data! as Data, metadata: nil, completion: {(metadata, error) in
//            guard metadata != nil else {
//                print("Error Occured to put")
//                return
//            }
//            self.profilePicsRef.child(imageName).downloadURL { (url, error) in
//                guard let downloadURL = url else {
//                    print("Error Occured \(error)")
//                    return
//                }
//                sourceVC.passedAthlete.url = downloadURL
//                self.athletes[selectedIndexPath.row] = sourceVC.passedAthlete
//                self.tableView.reloadRows(at: [selectedIndexPath], with: .none)
//                self.athleteDatabase.updateChildValues([sourceVC.passedAthlete.name : sourceVC.passedAthlete.toAnyObject()])
//            }
//        })
    }
    
}
