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
    
    let requestArray: NSArray = ["Request1", "Request2", "Request3", "Request4", "Request5", "Request6", "Request7", "Request8", "Request9"]
    private var myTableView: UITableView!
    private let cellId = "requestCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        //request label constraints
        requestsLabel.translatesAutoresizingMaskIntoConstraints = false
        let teamLeftConstraint = requestsLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        let teamTopConstraint = requestsLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        self.view.addConstraints([teamLeftConstraint, teamTopConstraint])
        
        //select team table view
        myTableView = UITableView()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "requestCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(RequestTableViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(myTableView)
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: requestsLabel.bottomAnchor, constant: 10)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
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
        print("Num: \(indexPath.row)")
        print("Value: \(requestArray[indexPath.row])")
        //TODO: Find a way to access cell elements here? So we can set each cell label to be what's in the array by using indexpath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RequestTableViewCell
        // swiftlint:enable force_cast
        return cell
    }
}

