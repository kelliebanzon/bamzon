//
//  ViewNC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/14/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class ViewNC: UINavigationController, DisplayableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = UIColor(named: "TSNavy")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}