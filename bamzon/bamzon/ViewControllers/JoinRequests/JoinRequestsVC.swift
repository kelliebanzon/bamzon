//
//  JoinRequestsVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class JoinRequestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, RefreshableProtocol {
    
    let joinRequestsVM = JoinRequestsVM()

    var myTableView = UITableView()
    let cellId = "requestCell"

    var requestsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Join Requests"
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(RequestTableViewCell.self, forCellReuseIdentifier: self.cellId)

        let dispatch = DispatchGroup()
        showSpinner(onView: self.view)
        joinRequestsVM.loadRequests(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.removeSpinner()
            self.display()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeJoinRequests)), animated: true)

        requestsLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        requestsLabel.numberOfLines = 0
        requestsLabel.textColor = .white
        requestsLabel.textAlignment = .left
        requestsLabel.text = "Requests"
        self.view.addSubview(requestsLabel)

        //select team table view
        myTableView = UITableView()
        myTableView.backgroundColor = .clear
        self.view.addSubview(myTableView)
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: requestsLabel.bottomAnchor, constant: 10)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        requestsLabel.translatesAutoresizingMaskIntoConstraints = false
        let teamLeftConstraint = requestsLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30)
        let teamTopConstraint = requestsLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50)
        self.view.addConstraints([teamLeftConstraint, teamTopConstraint])

    }

    @objc func closeJoinRequests(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    func refresh() {
        // TODO: implement refresh
    }
    
    func approve() {
        // TODO: implement approve
    }
    
    func reject(request: JoinRequest) {
        // TODO: implement reject join request
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.contentView.backgroundColor = UIColor(named: "TSYellow")

        print("Num: \(indexPath.row)")
        print("Value: \(joinRequestsVM.requestedUsers[indexPath.row].getFullName())")
        //TODO: Find a way to access cell elements here? So we can set each cell label to be what's in the array by using indexpath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joinRequestsVM.requestedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RequestTableViewCell
        // swiftlint:enable force_cast
        return cell
    }
}
