//
//  VCUtility.swift
//  bamzon
//
//  Created by Kevin Krein on 2/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func mockSegue(toIdentifier: String) {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: toIdentifier)
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func mockSegue(to: UIViewController) {
        self.present(to, animated: true, completion: nil)
    }
    
    func errorAlert(withMessage: String) {
        let alert = UIAlertController(title: "Error", message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
