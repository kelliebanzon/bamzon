//
//  CalendarVC.swift
//  bamzon
//
//  Created by Brandon Ryan on 12.03.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

enum MyTheme {
    case light
    case dark
}

class CalendarVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {
    
    var theme = MyTheme.dark
    var events = ["event1", "event2", "event3", "event4"]
    
    var calenderView: CalenderView = {
        let view = CalenderView(theme: MyTheme.dark)
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    private var myTableView: UITableView!
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        self.view.backgroundColor=Style.bgColor
        
        view.addSubview(calenderView)

        let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        
        display()
    }
    
    func display() {
        myTableView = UITableView()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(CalendarVCTableViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(myTableView)

        setupAutoLayout()
        
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        calenderView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 60).isActive=true
        calenderView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true

        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalToConstant: 280)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: calenderView.bottomAnchor, constant: 30)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = margins.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
        if theme == .dark {
            sender.title = "Dark"
            theme = .light
            Style.themeLight()
        } else {
            sender.title = "Light"
            theme = .dark
            Style.themeDark()
        }
        self.view.backgroundColor=Style.bgColor
        calenderView.changeTheme()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CalendarVCTableViewCell
        // swiftlint:enable force_cast
        /*let rsvpType = rsvpTypes[indexPath.row]
        let rsvp = rsvps[indexPath.row]
        
        cell.rsvpTypeLabel.text = rsvpType
        cell.rsvpsLabel.text = "\(rsvp)"
        */
        return cell
    }
    
    func edit() {
        
    }
    
    func refresh() {
        
    }
    
}
