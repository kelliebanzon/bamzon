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
        //requests label
        let requestsLabel = UILabel()
        requestsLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        requestsLabel.numberOfLines = 0
        requestsLabel.textColor = .white
        requestsLabel.textAlignment = .left
        requestsLabel.text = "Requests"
        self.view.addSubview(requestsLabel)
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeJoinRequests)), animated: true)
        
        //request label constraints
        requestsLabel.translatesAutoresizingMaskIntoConstraints = false
        let teamLeftConstraint = requestsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        let teamTopConstraint = requestsLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        self.view.addConstraints([teamLeftConstraint, teamTopConstraint])
        
        //select team table view
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        myTableView.allowsSelection = false
        self.view.addSubview(myTableView)
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: requestsLabel.bottomAnchor, constant: 10)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }
    
    @objc func closeJoinRequests(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func reject(request: JoinRequest) {
        // TODO: implement reject join request
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joinRequestsVM.requestedUsers.count
    }
    
    // Populate each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RequestTableViewCell
        // swiftlint:enable force_cast
        cell.teamName.text = joinRequestsVM.requestedUsers[indexPath.row].getFullName()
        cell.acceptButton.addTarget(self, action: #selector(approveRequest), for: .touchUpInside)
        cell.rejectButton.addTarget(self, action: #selector(rejectRequest), for: .touchUpInside)
        cell.blockButton.addTarget(self, action: #selector(blockRequest), for: .touchUpInside)
        cell.acceptButton.tag = indexPath.row
        return cell
    }
    
    @objc func approveRequest(sender: UIButton) {
        joinRequestsVM.approve(requestIndex: sender.tag)
    }
    
    @objc func rejectRequest(sender: UIButton) {
        print("I'm supposed to reject: " + String(sender.tag))
        let dispatch = DispatchGroup()
        joinRequestsVM.reject(requestIndex: sender.tag, dispatch: dispatch)
    }
    
    @objc func blockRequest(sender: UIButton) {
        print("I'm supposed to block: " + String(sender.tag))
        alert(withTitle: "❌ Block Request ❌", withMessage: "Feature not implemented")
    }
}
