//
//  TabBarController.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/08/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate, DisplayableProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        tabBar.barStyle = .black
        tabBar.isTranslucent = true
        tabBar.barTintColor = UIColor(named: "TSNavy")
        tabBar.tintColor = UIColor(named: "TSYellow")
        tabBar.unselectedItemTintColor = UIColor(named: "BZNDarkGray")
        
        let rosterVC = RosterVC()
        rosterVC.tabBarItem = UITabBarItem(title: "Roster", image: UIImage(named: "clipboard"), tag: 0)

        let attendanceVC = AttendanceParentVC()
        attendanceVC.tabBarItem = UITabBarItem(title: "Attendance", image: UIImage(named: "checkbox"), tag: 1)

        let teamHomeVC = TeamHomeVC()
        teamHomeVC.tabBarItem = UITabBarItem(title: "Team Home", image: UIImage(named: "home"), tag: 2)

        let calendarVC = CalendarVC()
        calendarVC.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar"), tag: 3)

        let statsVC = StatsParentVC()
        statsVC.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named: "graph"), tag: 4)

        let vcs = [rosterVC, attendanceVC, teamHomeVC, calendarVC, statsVC]
        viewControllers = vcs.map {
            createDefaultNavigationController(rootViewController: $0)
        }

        selectedIndex = 2
    }

}
