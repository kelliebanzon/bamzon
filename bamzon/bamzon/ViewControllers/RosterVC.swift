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
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        //roster label
        let rosterLabel = UILabel()
        rosterLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        rosterLabel.numberOfLines = 0
        rosterLabel.textColor = .white
        rosterLabel.textAlignment = .left
        rosterLabel.text = "Roster"
        self.view.addSubview(rosterLabel)
        
        //roster label constraints
        rosterLabel.translatesAutoresizingMaskIntoConstraints = false
        let rosterTopConstraint = rosterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        let rosterLeftConstraint = rosterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        self.view.addConstraints([rosterTopConstraint, rosterLeftConstraint])
        
        //table view
        /*let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height*/
        
        //myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView = UITableView()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(myTableView)
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: rosterLabel.bottomAnchor, constant: 20)
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
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

class CustomTableViewCell: UITableViewCell {
    
    let imgUser: UIImageView = {
        let pic = UIImageView()
        pic.contentMode = .scaleAspectFill
        pic.clipsToBounds = true
        pic.image = UIImage(named: "BZN-Square-Logo")
        pic.layer.cornerRadius = 35
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Last, First"
        label.minimumScaleFactor = 0.25
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userNumber: UILabel = {
        let num = UILabel()
        num.font = UIFont(name: "HelveticaNeue", size: 17)
        num.numberOfLines = 1
        num.textColor = .white
        num.textAlignment = .left
        num.text = "420-666-6969"
        num.translatesAutoresizingMaskIntoConstraints = false
        return num
    }()
    let userEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        label.text = "willywonka@chocolate.com"
        label.minimumScaleFactor = 0.25
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let userYear: UILabel = {
        let year = UILabel()
        year.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        year.numberOfLines = 1
        year.textColor = .white
        year.textAlignment = .left
        year.text = "3"
        year.translatesAutoresizingMaskIntoConstraints = false
        return year
    }()
    let userRole: UILabel = {
        let role = UILabel()
        role.font = UIFont(name: "HelveticaNeue", size: 17)
        role.numberOfLines = 1
        role.textColor = .white
        role.textAlignment = .left
        role.text = "Member"
        role.translatesAutoresizingMaskIntoConstraints = false
        return role
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
        contentView.addSubview(imgUser)
        contentView.addSubview(userNumber)
        contentView.addSubview(userEmail)
        contentView.addSubview(userYear)
        contentView.addSubview(userRole)
        setupAutoLayout()
    }
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        
        //contentView.backgroundColor = UIColor(named: "TSTeal")
        
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userNumber.translatesAutoresizingMaskIntoConstraints = false
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        userYear.translatesAutoresizingMaskIntoConstraints = false
        userRole.translatesAutoresizingMaskIntoConstraints = false
        
        //username
        userName.text = "Brandon"
        userName.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        userName.numberOfLines = 0
        userName.textColor = .white
        userName.textAlignment = .center
        
        contentView.addSubview(imgUser)
        contentView.addSubview(userName)
        contentView.addSubview(userNumber)
        contentView.addSubview(userEmail)
        contentView.addSubview(userYear)
        contentView.addSubview(userRole)
        setupAutoLayout()
    }*/
    
    func setupAutoLayout() {
        //image constraints
        let imgLeftConstraint = imgUser.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let imgVertConstraint = imgUser.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -35)
        let imgWidthConstraint = imgUser.widthAnchor.constraint(equalToConstant: 70)
        let imgHeightConstraint = imgUser.heightAnchor.constraint(equalToConstant: 70)
        self.contentView.addConstraints([imgLeftConstraint, imgVertConstraint, imgWidthConstraint, imgHeightConstraint])
        
        //name constraints
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let nameWidthConstraint = userName.widthAnchor.constraint(equalToConstant: 100)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        //number constraints
        let numLeftConstraint = userNumber.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let numTopConstraint = userNumber.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5)
        self.contentView.addConstraints([numLeftConstraint, numTopConstraint])
        
        //email constraints
        let emailLeftConstraint = userEmail.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let emailTopConstraint = userEmail.topAnchor.constraint(equalTo: userNumber.bottomAnchor, constant: 5)
        let emailRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: userEmail.trailingAnchor, constant: 20)
        self.contentView.addConstraints([emailLeftConstraint, emailTopConstraint, emailRightConstraint])
        
        //year constraints
        let yearRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: userYear.trailingAnchor, constant: 15)
        let yearTopConstraint = userYear.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        self.contentView.addConstraints([yearRightConstraint, yearTopConstraint])
        
        //role constraints
        let roleRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: userRole.trailingAnchor, constant: 15)
        let roleTopConstraint = userRole.topAnchor.constraint(equalTo: userYear.bottomAnchor, constant: 5)
        self.contentView.addConstraints([roleRightConstraint, roleTopConstraint])
    }
}
