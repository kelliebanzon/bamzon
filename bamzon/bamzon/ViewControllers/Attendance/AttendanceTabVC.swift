//
//  AttendanceTabVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/19/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class AttendanceTabVC: ButtonBarPagerTabStripViewController, DisplayableProtocol {
    
    override func viewDidLoad() {
        // NOTE: display must be called before viewDidLoad to comply with XLPagerTabStrip
        display()
        super.viewDidLoad()
    }
    
    func display() {
        settings.style.buttonBarBackgroundColor = UIColor(named: "TSNavy")
        settings.style.buttonBarItemBackgroundColor = UIColor(named: "TSNavy")
        settings.style.selectedBarBackgroundColor = UIColor(named: "TSYellow") ?? UIColor.lightGray
        settings.style.buttonBarItemFont = VCUtility().header3Font ?? UIFont.systemFont(ofSize: 14)

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(named: "TSLightGray")
            newCell?.label.textColor = .white
        }
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let playersVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AttendanceChildPlayersVC")
        let practicesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AttendanceChildPracticesVC")
        return [playersVC, practicesVC]
    }
}
