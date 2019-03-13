//
//  AttendanceChildPlayersVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/19/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class AttendanceChildPlayersVC: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider, DisplayableProtocol, RefreshableProtocol, EditableProtocol {

    let cellId = "cellId"
    
    var playersTableView: UITableView = UITableView()
    var playersList: [String] = ["Chaussabel, Adrien", "Gallahue, Caoimhe", "Guadiamos, Ariela", "Hazell, Jordan", "Hofferth, Elliott", "Imobersteg, Andrew", "Lopez, Samuel", "Robinson, Greg", "Sichel, Ben", "Soo, Tyler", "Trudell, Avery", "Vu, Kyle", "Wasson, Jedd", "Webster, David", "Woods, Ana"]
    
    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersTableView.dataSource = self
        playersTableView.delegate = self
        playersTableView.register(PlayersAttendanceTableViewCell.self, forCellReuseIdentifier: "cellId")
        display()
    }
    
    func display() {
        // TODO: implement display
        
        view.backgroundColor = UIColor(named: "TSTeal")
        playersTableView.backgroundColor = UIColor(named: "TSTeal")
        playersTableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(playersTableView)
        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        // Players Table View Constraints
        playersTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableTop = playersTableView.topAnchor.constraint(equalTo: view.topAnchor)
        let tableLeading = playersTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableTrailing = margins.trailingAnchor.constraint(equalTo: playersTableView.trailingAnchor)
        let tableBottom = margins.bottomAnchor.constraint(equalTo: playersTableView.bottomAnchor, constant: 85)
        self.view.addConstraints([tableTop, tableLeading, tableTrailing, tableBottom])
    }
    
    // Setting number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows to present
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    // Populate value at selected row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlayersAttendanceTableViewCell
        // swiftlint:enable force_cast
        cell.userName.text = playersList[indexPath.row]
        cell.userName.textColor = .white
        cell.backgroundColor = UIColor(named: "TSTeal")
        return cell
    }
    
    // Function to handle what setting to call
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert(withTitle: "Player Selected", withMessage: "Show " + playersList[indexPath.row] + "'s personal attendance")
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.contentView.backgroundColor = UIColor(named: "TSYellow")
    }
    
    func refresh() {
        // TODO: implement refresh
    }

    func edit() {
        // TODO: implement edit
    }

    // MARK: - Navigation

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Today's Practice")
    }

    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
