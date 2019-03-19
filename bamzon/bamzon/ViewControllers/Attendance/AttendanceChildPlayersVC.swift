//
//  AttendanceChildCurrentVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/19/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class AttendanceChildCurrentVC: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider, DisplayableProtocol, RefreshableProtocol, EditableProtocol {

    private let refreshControl = UIRefreshControl()
    let cellId = "cellId"
    
    var playersTableView: UITableView = UITableView()
    var attendanceVM = AttendanceVM()
    
    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.dataSource = self
        playersTableView.delegate = self
        playersTableView.register(CurrentAttendanceTableViewCell.self, forCellReuseIdentifier: "cellId")
        
        if #available(iOS 10.0, *) {
            playersTableView.refreshControl = refreshControl
        } else {
            playersTableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        
        let dispatch = DispatchGroup()
        showSpinner(onView: self.view)
        attendanceVM.loadAttendance(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.removeSpinner()
            self.display()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        playersTableView.backgroundColor = .clear
        // For demo purposes - disable selection
        playersTableView.allowsSelection = false
        self.view.addSubview(playersTableView)
        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        // Players Table View Constraints
        playersTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableTop = playersTableView.topAnchor.constraint(equalTo: margins.topAnchor)
        let tableLeading = playersTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableTrailing = margins.trailingAnchor.constraint(equalTo: playersTableView.trailingAnchor)
        let tableBottom = margins.bottomAnchor.constraint(equalTo: playersTableView.bottomAnchor)
        self.view.addConstraints([tableTop, tableLeading, tableTrailing, tableBottom])
    }
    
    // Number of sections to display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of members to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceVM.members.count
    }
    
    // Populate each cell with a member
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CurrentAttendanceTableViewCell
        // swiftlint:enable force_cast
        let thisUser = attendanceVM.members[indexPath.row]
        cell.userName.text = thisUser.getFullName()
        cell.userName.textColor = .white
        // Sets the tag to the current index being used to populate the cell
        // This can be used later to identify which user is being interacted with
        cell.attendanceType.tag = indexPath.row
        if let curPractice = attendanceVM.selectedPractice {
            if curPractice.attendingUsers[thisUser.userID] != nil {
                self.changePresent(sender: cell.attendanceType)
            } else if curPractice.excusedUsers[thisUser.userID] != nil {
                self.changeExcused(sender: cell.attendanceType)
            } else {
                self.changeAbsent(sender: cell.attendanceType)
            }
        }
        
        cell.attendanceType.addTarget(self, action: #selector(attendanceTypeClick), for: .touchUpInside)
        return cell
    }
    
    // Cycle through attendance types of Absent/Present/Excused
    @objc func attendanceTypeClick(sender: UIButton) {
        if sender.currentTitle! == "Absent" {
            changePresent(sender: sender)
            attendanceVM.markPresent(userIndex: sender.tag)
        } else if sender.currentTitle == "Present" {
            changeExcused(sender: sender)
            attendanceVM.markExcused(userIndex: sender.tag)
        } else if sender.currentTitle == "Excused" {
            changeAbsent(sender: sender)
            attendanceVM.markAbsent(userIndex: sender.tag)
        } else {
            sender.setTitle("Uh oh! 😰", for: .normal)
            sender.backgroundColor = UIColor(named: "TSYellow")
        }
        // Using sender.tag to index into the list of members to get specific user
        print(attendanceVM.members[sender.tag].getFullName() + " is " + sender.currentTitle!)
    }
    
    func changePresent(sender: UIButton) {
        sender.setTitle("Present", for: .normal)
        sender.backgroundColor = UIColor(named: "TSGreen")
    }
    
    func changeExcused(sender: UIButton) {
        sender.setTitle("Excused", for: .normal)
        sender.backgroundColor = UIColor(named: "TSGray")
    }
    
    func changeAbsent(sender: UIButton) {
        sender.setTitle("Absent", for: .normal)
        sender.backgroundColor = UIColor(named: "TSOrange")
    }
    
    // Display selected user's attendance history
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.contentView.backgroundColor = UIColor(named: "TSYellow")
        alert(withTitle: "Player Selected", withMessage: "Show " + attendanceVM.members[indexPath.row].getFullName() + "'s personal attendance")
    }
    
    @objc private func refresh(_ sender: Any) {
        refresh()
        self.refreshControl.endRefreshing()
    }
    
    func refresh() {
        let dispatch = DispatchGroup()
        attendanceVM.refreshCurrentPractice(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.playersTableView.reloadData()
            self.display()
        }
    }

    func edit() {
        // TODO: implement edit
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Today's Practice")
    }

}
