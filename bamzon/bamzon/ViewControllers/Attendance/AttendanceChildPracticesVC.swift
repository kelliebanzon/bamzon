//
//  AttendanceChildPracticesVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/19/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class AttendanceChildPracticesVC: UIViewController, IndicatorInfoProvider, DisplayableProtocol, RefreshableProtocol, EditableProtocol {

    var tempLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }

    func display() {
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSOrange")

        tempLabel = createDefaultLabel(text: description, numLines: 0)
        tempLabel.textAlignment = .center
        tempLabel.lineBreakMode = .byWordWrapping
        self.view.addSubview(tempLabel)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        let tempLabelVertConstraint = tempLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        let tempLabelLeadingConstraint = tempLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let tempLabelTrailingConstraint = margins.trailingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([tempLabelVertConstraint, tempLabelLeadingConstraint, tempLabelTrailingConstraint])
    }

    func refresh() {
        // TODO: implement refresh
    }

    func edit() {
        // TODO: implement edit
    }

    // MARK: - Navigation

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Practices")
    }

    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
