//
//  AppDelegate.swift
//  bamzon
//
//  Created by Kellie Banzon on 11/15/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var curTeam: Team?
    var curUser: User?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        curUser = User(userID: IDUtility.generateIDFromString(idString: "u404"), firstName: "Jake", lastName: "Peralta", nickname: nil, phone: "(123) 456-7890", email: "jperal@calpoly.edu", schoolYear: nil, bio: "The best detective in all of Brooklyn!", imageURL: nil, teamIDs: [ID(type: "t", num: 404)])
        
        //Initializer user on login or opening app
        if let user = Auth.auth().currentUser {
            DBUtility.readFromDB(table: FirTable.firebaseID, keys: user.uid, completion: { (key: String, idSnap: [String: AnyObject]) -> Void in
                
                if let userID = idSnap["userID"] as? String {
                    DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: { (key: String, idSnap: [String: AnyObject]) -> Void in
                        self.curUser = User(key: user.uid, payload: idSnap)
                    })
                }
                
            })
        }
        
        curTeam = Team(teamID: ID(type: "t", num: 404), orgID: ID(type: "o", num: 404), userIDs: [ID(type: "u", num: 404)], teamName: "Test Team", sport: "Cricket", stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)

//        showTabController()
        window?.makeKeyAndVisible()
        return true
    }

    func showTabController() {
        self.window?.rootViewController = TabBarController()
        self.window?.rootViewController?.viewDidLoad()
    }

    func hideTabController() {
        self.window?.rootViewController = nil
    }

    func applicationWillResignActive(_ application: UIApplication) {
//        Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary
//        interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins
//        the transition to the background state.
//        Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
//        Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state
        // information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when
        // the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of
        // the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the
        // application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate.
        // See also applicationDidEnterBackground:.
    }

}
