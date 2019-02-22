//
//  RosterVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class RosterVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {

    let myArray: NSArray = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh"]
    private var myTableView: UITableView!
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Roster"
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        myTableView = UITableView()
        //myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(RosterTableViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(myTableView)
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
        selectUser()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RosterTableViewCell
        // swiftlint:enable force_cast
        return cell
    }
    
    func edit() {
        // TODO: implement edit
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func selectUser() {
        // TODO: implement selectUser
    }
    
    func sortBy(filter: String) {
        // TODO: implement sort by
    }
    
}
