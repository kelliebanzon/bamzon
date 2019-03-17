//
//  SelectTeamVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

// List of teams for user

class SelectTeamVM: LoggedInViewModel {
    
    var teams: [Team] = []
    var organizations: [Organization] = [] //correspond to matching index in teams array
    
    func refresh(dispatch: DispatchGroup) {
        loadTeams(dispatch: dispatch)
    }
    
    func loadTeams(dispatch: DispatchGroup) {
        teams.removeAll()
        organizations.removeAll()
        for teamID in self.user.teamIDs {
            loadTeam(teamID: teamID.key, dispatch: dispatch)
        }
        
    }

    func loadTeam(teamID: ID, dispatch: DispatchGroup) {
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
            let team = Team(key: key, payload: teamSnap)
            self.teams.append(team)
            self.loadOrg(orgID: team.orgID, dispatch: dispatch)
            dispatch.leave()
        })
    }

    func loadOrg(orgID: ID, dispatch: DispatchGroup) {
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.organization, keys: orgID, completion: { (key: String, orgSnap: [String: AnyObject]) -> Void in
            let org = Organization(key: key, payload: orgSnap)
            self.organizations.append(org)
            dispatch.leave()
        })
    }
    
    func selectTeam(team: Team, dispatch: DispatchGroup) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.curTeam = team
            setTeamUsers(teamID: team.teamID, dispatch: dispatch)
            setTeamCalendar(teamID: team.teamID, dispatch: dispatch)
        }
    }
    
    func setTeamUsers(teamID: ID, dispatch: DispatchGroup) {
        var queriedUsers: [User] = []
        
        dispatch.enter()
        
        let userDispatch = DispatchGroup()
        
        for userID in appDelegate.curTeam?.userIDs ?? [:] {
            userDispatch.enter()
            DBUtility.readFromDB(table: FirTable.user, keys: userID.value) { (key: String, payload: [String: AnyObject]) in
                queriedUsers.append(User(key: key, payload: payload))
                userDispatch.leave()
            }
        }
        
        userDispatch.notify(queue: DispatchQueue.main) {
            self.appDelegate.users = queriedUsers
            dispatch.leave()
        }
    }
    
    func setTeamCalendar(teamID: ID, dispatch: DispatchGroup) {
        var queriedCalendar: TeamCalendar?
        
        dispatch.enter()
        
        let calendarDispatch = DispatchGroup()
        calendarDispatch.enter()
        
        DBUtility.readFromDB(table: FirTable.teamCalendar, keys: self.appDelegate.curTeam?.teamID ?? ID(type: "zz", uuid: "00")) { (key: String, payload: [String: AnyObject]) in
            queriedCalendar = TeamCalendar(key: key, payload: payload)
            calendarDispatch.leave()
        }
        
        calendarDispatch.notify(queue: DispatchQueue.main) {
            self.appDelegate.calendar = queriedCalendar
            self.setTeamEvents(teamCal: queriedCalendar, dispatch: dispatch)
        }
    }
        
    func setTeamEvents(teamCal: TeamCalendar?, dispatch: DispatchGroup) {
        if teamCal == nil {
            return
        }
        var queriedEvents: [Event] = []
        
        let eventDispatch = DispatchGroup()
        
            for eventID in teamCal?.eventIDs ?? [] {
                eventDispatch.enter()
                DBUtility.readFromDB(table: FirTable.event, keys: eventID ?? ID(type: "zz", uuid: "00")) { (key: String, payload: [String: AnyObject]) in
                    queriedEvents.append(Event(key: key, payload: payload))
                    eventDispatch.leave()
                }
            }

        eventDispatch.notify(queue: DispatchQueue.main) {
            self.appDelegate.events = queriedEvents
            dispatch.leave()
        }
    }
    
}
