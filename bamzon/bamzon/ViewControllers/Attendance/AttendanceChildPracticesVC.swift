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

class AttendanceChildPracticesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider, DisplayableProtocol, RefreshableProtocol, EditableProtocol {

    private let refreshControl = UIRefreshControl()
    let cellId = "cellId"
    
    var datesTableView: UITableView = UITableView()
    var attendanceVM = AttendanceVM()
    
    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datesTableView.dataSource = self
        datesTableView.delegate = self
        datesTableView.register(AttendancePracticesTableViewCell.self, forCellReuseIdentifier: "cellId")

        if #available(iOS 10.0, *) {
            datesTableView.refreshControl = refreshControl
        } else {
            datesTableView.addSubview(refreshControl)
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
        datesTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(datesTableView)
        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide
        datesTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableTop = datesTableView.topAnchor.constraint(equalTo: margins.topAnchor)
        let tableLeading = datesTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableTrailing = margins.trailingAnchor.constraint(equalTo: datesTableView.trailingAnchor)
        let tableBottom = margins.bottomAnchor.constraint(equalTo: datesTableView.bottomAnchor)
        self.view.addConstraints([tableTop, tableLeading, tableTrailing, tableBottom])
    }
    
    // Number of sections to display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of practices to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceVM.practices.count
    }
    
    // Populate each cell with a practice
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AttendancePracticesTableViewCell
        // swiftlint:enable force_cast
        cell.practiceDate.text = attendanceVM.practices[indexPath.row].date.toStringPretty()
        cell.practiceDate.textColor = .white
        cell.backgroundColor = UIColor(named: "TSTeal")
        cell.highlightYellowOnSelection()
        return cell
    }
    
    // Display selected date's practice and corresponding attendance
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert(withTitle: "Date Selected", withMessage: "Show " + attendanceVM.practices[indexPath.row].date.toStringPretty() + "'s attendance")
    }
    
    @objc private func refresh(_ sender: Any) {
        refresh()
        self.refreshControl.endRefreshing()
    }

    func refresh() {
        let dispatch = DispatchGroup()
        attendanceVM.refreshPractices(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.datesTableView.reloadData()
            self.display()
        }
    }

    func edit() {
        // TODO: implement edit
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Past Practices")
    }

}
