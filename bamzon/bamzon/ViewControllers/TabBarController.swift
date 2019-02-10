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
        view.backgroundColor = UIColor(named: "TSTeal")
        
        //tabBar.barStyle = UIBarStyle(rawValue: 1) ?? UIBarStyle(rawValue: 0)!
        tabBar.isTranslucent = true
        tabBar.barTintColor = UIColor(named: "TSNavy") ?? UIColor.black
        tabBar.tintColor = UIColor(named: "TSYellow")
        tabBar.unselectedItemTintColor = UIColor(named: "BZNDarkGray")
        
        // TODO: should this code actually be in display?
//        let downloadViewController = DownloadsViewController()
//        downloadViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Downloads, tag: 0)
//        let bookmarkViewController = BookmarksViewController()
//        bookmarkViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .Bookmarks, tag: 1)
//        let favoritesViewControllers = FavoritesViewController()
//        favoritesViewControllers.tabBarItem = UITabBarItem(tabBarSystemItem: .Favorites, tag: 2)
//        let viewControllerList = [ downloadViewController, bookmarkViewController, favoritesViewControllers ]
//        viewControllers = viewControllerList
        
        //let attendanceVC = AttendanceVC()
        //attendanceVC.tabBarItem = UITabBarItem(title: <#T##String?#>, image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
        let rosterVC = RosterVC()
        rosterVC.tabBarItem = UITabBarItem(title: "Roster", image: UIImage(named: "home-TSNavy"), selectedImage: UIImage(named: "home-TSYellow"))
        
        let attendanceVC = AttendanceVC()
        attendanceVC.tabBarItem = UITabBarItem(title: "Attendance", image: UIImage(named: "home-TSNavy"), selectedImage: UIImage(named: "home-TSYellow"))
        
        let teamHomeVC = TeamHomeVC()
        teamHomeVC.tabBarItem = UITabBarItem(title: "Team Home", image: UIImage(named: "home-TSNavy"), selectedImage: UIImage(named: "home-TSYellow"))
        
        let calendarVC = CalendarVC()
        calendarVC.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "home-TSNavy"), selectedImage: UIImage(named: "home-TSYellow"))
        
        let statsVC = StatsParentVC()
        statsVC.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named: "home-TSNavy"), selectedImage: UIImage(named: "home-TSYellow"))
        
        // TODO: change this to be the nav controllers instead of the controllers themselves
        let vcs = [rosterVC, attendanceVC, teamHomeVC, calendarVC, statsVC]
        viewControllers = vcs.map {UINavigationController(rootViewController: $0)}
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
