//
//  ImageUtility.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class ImageUtility {
    let defaultProfilePictureName = "default-profile-picture"

    func createImageView(imageName: String) -> UIImageView {
        let imgView = UIImageView(image: UIImage(named: imageName))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }

    func createSquircleImageView(imageName: String) -> UIImageView {
        let imgView = createImageView(imageName: imageName)
        imgView.layer.cornerRadius = 15.0
        return imgView
    }

    enum ImageViewStyle {
        case squircle
        case square
    }

    func createProfilePictureImageView(imageName: String?, style: ImageViewStyle) -> UIImageView {
        let img: String
        if let nonNilImageName = imageName, nonNilImageName.count != 0 {
            print("first")
            // swiftlint: disable force_cast
            img = imageName!
            // swiftlint: enable force_cast
        } else {
            print("else")
            img = defaultProfilePictureName
        }
        switch style {
        case .squircle:
            return createSquircleImageView(imageName: img)
        default:
            return createImageView(imageName: img)
        }
    }
}

extension UIImageView {
    
    func roundCorners() {
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
}
