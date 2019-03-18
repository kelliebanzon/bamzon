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

class CalendarVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol, Observer {
    
    var theme = MyTheme.dark
    var events: [Event] = [] // need this to be from firebase based on date
    //there is a getDate function that you could call when you click on a square, right now it just prints(date.ToString)
    var eventLabel = UILabel()
    var dateLabel = UILabel()
    var locLabel = UILabel()
    var calendarVM: CalendarVM = CalendarVM()
    var observers: Observer?
    var dateString: String = ""
    
    var calendarView: CalendarView = {
        let view = CalendarView(theme: MyTheme.dark)
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    private var myTableView: UITableView!
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        self.view.backgroundColor=Style.bgColor
        calendarVM.refresh()
        calendarView.addObserver(obs: self)
        
        view.addSubview(calendarView)

        let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        
        display()
        addSubviews()
        setupAutoLayout()
    }
    
    func update() {
        dateString = calendarView.getDateString()
        events = calendarVM.getEventsFor(dateStr: dateString)
        print("events at date: \(dateString) : \(events)")
        display()
    }
    
    func display() {
        myTableView = UITableView()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(CalendarVCTableViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(myTableView)
        
        eventLabel = createDefaultLabel(text: "Event", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        dateLabel = createDefaultLabel(text: "Date", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        locLabel = createDefaultLabel(text: "Location", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
    }
    
    func addSubviews() {
        self.view.addSubview(myTableView)
        self.view.addSubview(eventLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(locLabel)
    }
    
    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide
    
        calendarView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive=true
        calendarView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -12).isActive=true
        calendarView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 12).isActive=true
        calendarView.heightAnchor.constraint(equalToConstant: 365).isActive=true
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalToConstant: 280)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 30)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = margins.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
        
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventLeftConstraint = eventLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
        let eventBottomConstraint = eventLabel.bottomAnchor.constraint(equalTo: myTableView.topAnchor, constant: -10)
        self.view.addConstraints([eventLeftConstraint, eventBottomConstraint])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateLeftConstraint = dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.frame.width * 2/5)
        let dateBottomConstraint = dateLabel.bottomAnchor.constraint(equalTo: myTableView.topAnchor, constant: -10)
        self.view.addConstraints([dateLeftConstraint, dateBottomConstraint])
        
        locLabel.translatesAutoresizingMaskIntoConstraints = false
        //let locRightConstraint = locationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        let locLeftConstraint = locLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: self.view.frame.width * 1/5)
        let locBottomConstraint = locLabel.bottomAnchor.constraint(equalTo: myTableView.topAnchor, constant: -10)
        self.view.addConstraints([locLeftConstraint, locBottomConstraint])

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendarView.myCollectionView.collectionViewLayout.invalidateLayout()
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
        calendarView.changeTheme()
    }
    
    // Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    // Number of events to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // Populate each cell with an event
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CalendarVCTableViewCell
        // swiftlint:enable force_cast
        cell.highlightYellowOnSelection()
        
        let event = events[indexPath.row]
        
        cell.eventLabel.text = event.name
        cell.dateLabel.text = event.date.prettyPrint()
//        cell.locLabel.text = event.locationID?.description
        
        return cell
    }
    
    func edit() {
        
    }
    
    func refresh() {
        
    }
    
}
