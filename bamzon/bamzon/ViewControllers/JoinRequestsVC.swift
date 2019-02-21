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

class RequestTableViewCell: UITableViewCell {
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Requestor Name"
        label.minimumScaleFactor = 0.25
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 20 )
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Team Location"
        label.minimumScaleFactor = 0.25
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //acceptbutton
    let accept: UIButton = {
        let button = UIButton()
        button.setTitle("Accept", for: .normal)
        button.backgroundColor = UIColor(named: "TSYellow")
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        button.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        button.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let reject: UIButton = {
        let button = UIButton()
        button.setTitle("Reject", for: .normal)
        button.backgroundColor = UIColor(named: "TSYellow")
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        button.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        button.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let block: UIButton = {
        let button = UIButton()
        button.setTitle("Block", for: .normal)
        button.backgroundColor = UIColor(named: "TSYellow")
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        button.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        button.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        addSubviewsAndLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviewsAndLayout() {
        contentView.addSubview(userName)
        contentView.addSubview(teamName)
        contentView.addSubview(accept)
        contentView.addSubview(reject)
        contentView.addSubview(block)
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        
        //name constraints
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15)
        let nameWidthConstraint = userName.widthAnchor.constraint(equalToConstant: 130)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        //team name constraints
        let teamLeftConstraint = teamName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let teamTopConstraint = teamName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5)
        let teamWidthConstraint = teamName.widthAnchor.constraint(equalToConstant: 130)
        self.contentView.addConstraints([teamLeftConstraint, teamTopConstraint, teamWidthConstraint])
        
        //block constraints
        let blockRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: block.trailingAnchor, constant: 10)
        let blockTopConstraint = block.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let blockWidthConstraint = block.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([blockRightConstraint, blockTopConstraint, blockWidthConstraint])//, teamWidthConstraint])
    
        //accept constraints
        let acceptLeftConstraint = accept.leadingAnchor.constraint(greaterThanOrEqualTo: userName.trailingAnchor, constant: 10)
        let acceptTopConstraint = accept.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let acceptWidthConstraint = accept.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([acceptLeftConstraint, acceptTopConstraint, acceptWidthConstraint])
            
        //reject constraints
        let rejectRightConstraint = reject.trailingAnchor.constraint(equalTo: block.leadingAnchor, constant: -5)
        let rejectTopConstraint = reject.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let rejectLeftConstraint = reject.leadingAnchor.constraint(equalTo: accept.trailingAnchor, constant: 5)
        let rejectWidthConstraint = reject.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([rejectRightConstraint, rejectTopConstraint, rejectLeftConstraint, rejectWidthConstraint])
        
    }
    // Highlight the button upon touchDown
    @objc func highlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellowDark")
    }
    
    // Unhighlight the button upon touchDown
    @objc func unhighlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellow")
    }
}
