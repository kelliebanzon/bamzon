//
//  EventVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class EventVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {//, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var eventName = UILabel()
    var dateHeader = UILabel()
    var dateLabel = UILabel()
    var timeHeader = UILabel()
    var timeLabel = UILabel()
    var locationHeader = UILabel()
    var locationLabel = UILabel()
    var contactHeader = UILabel()
    var contactLabel = UILabel()
    var tagsLabel = UILabel()
    var detailsLabel = UILabel()
    var detailsTextBox = UITextView()
    var rsvpHeader = UILabel()
    var rsvpBox = UITextField()
    //TODO: Register on event page button
    
    let rsvpTypes = ["Yes:", "No:", "Maybe:", "Pending:"]
    
    let rsvps = [30, 46, 110, 120]
    
    private var myTableView: UITableView!
    private let cellId = "MyCell"
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1000
        view.backgroundColor = UIColor(named: "TSTeal")
        return view
    }()
    
    //private var myUIPicker: UIPickerView!
    //private let rsvpChoices: NSArray = ["Yes", "No", "Maybe", "Pending"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView = UITableView()
        //myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(EventTableViewCellVC.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        
        display()
        self.view.addSubview(scrollView)
        setupScrollView()
        setupAutoLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
    }
    
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        eventName = createDefaultLabel(text: "This is the Event Name", fontSize: 30, numLines: 0, fontColor: .white, fontAlignment: .center)
        dateHeader = createDefaultLabel(text: "Date: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        timeHeader = createDefaultLabel(text: "Time: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        locationHeader = createDefaultLabel(text: "Location: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        contactHeader = createDefaultLabel(text: "Contact: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        tagsLabel = createDefaultLabel(text: "Tags: ", fontSize: 17, numLines: 0, fontColor: .white, fontAlignment: .left)
        detailsLabel = createDefaultLabel(text: "Details", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        detailsTextBox.textAlignment = .left
        detailsTextBox.font = UIFont(name: "HelveticaNeue", size: 17)
        detailsTextBox.text = "This is an example bio This is an example bioThis is an example bioThis is an example bioThis is an example bioThis is an example bioThis is an example bioThis is an example bio"
        detailsTextBox.textColor = .white
        detailsTextBox.isEditable = false
        detailsTextBox.backgroundColor = UIColor(named: "TSTeal")
        adjustUITextViewHeight(arg: detailsTextBox)
        rsvpHeader = createDefaultLabel(text: "RSVP", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        rsvpBox.leftViewMode = .always
        rsvpBox.attributedPlaceholder = NSAttributedString(string: "Going?", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        rsvpBox.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        rsvpBox.textColor = .white
        
        //pickerview
        /*myUIPicker = UIPickerView()
         myUIPicker.delegate = self
         myUIPicker.dataSource = self
         myUIPicker.backgroundColor = .white
         
         rsvpBox.inputView = myUIPicker*/
        
        addSubviews()
    }    
    
    func setupAutoLayout() {
        eventName.translatesAutoresizingMaskIntoConstraints = false
        let nameHorizConstraint = eventName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let nameTopConstraint = eventName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80)
        let nameLeftConstraint = eventName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let nameRightConstraint = scrollView.trailingAnchor.constraint(equalTo: eventName.trailingAnchor, constant: 30)
        scrollView.addConstraints([nameTopConstraint, nameHorizConstraint, nameLeftConstraint, nameRightConstraint])
        
        dateHeader.translatesAutoresizingMaskIntoConstraints = false
        let dateHeaderLeftConstraint = dateHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let dateHeaderRightConstraint = scrollView.trailingAnchor.constraint(equalTo: dateHeader.trailingAnchor, constant: 30)
        let dateHeaderTopConstraint = dateHeader.topAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 40)
        scrollView.addConstraints([dateHeaderTopConstraint, dateHeaderLeftConstraint, dateHeaderRightConstraint])
        
        timeHeader.translatesAutoresizingMaskIntoConstraints = false
        let timeHeaderLeftConstraint = timeHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let timeHeaderRightConstraint = scrollView.trailingAnchor.constraint(equalTo: timeHeader.trailingAnchor, constant: 30)
        let timeHeaderTopConstraint = timeHeader.topAnchor.constraint(equalTo: dateHeader.bottomAnchor, constant: 10)
        scrollView.addConstraints([timeHeaderLeftConstraint, timeHeaderTopConstraint, timeHeaderRightConstraint])
        
        locationHeader.translatesAutoresizingMaskIntoConstraints = false
        let locHeaderLeftConstraint = locationHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let locHeaderRightConstraint = scrollView.trailingAnchor.constraint(equalTo: locationHeader.trailingAnchor, constant: 30)
        let locHeaderTopConstraint = locationHeader.topAnchor.constraint(equalTo: timeHeader.bottomAnchor, constant: 10)
        scrollView.addConstraints([locHeaderLeftConstraint, locHeaderTopConstraint, locHeaderRightConstraint])
        
        contactHeader.translatesAutoresizingMaskIntoConstraints = false
        let contactHeaderLeftConstraint = contactHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let contactHeaderRightConstraint = scrollView.trailingAnchor.constraint(equalTo: contactHeader.trailingAnchor, constant: 30)
        let contactHeaderTopConstraint = contactHeader.topAnchor.constraint(equalTo: locationHeader.bottomAnchor, constant: 10)
        scrollView.addConstraints([contactHeaderLeftConstraint, contactHeaderTopConstraint, contactHeaderRightConstraint])
        
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        let tagsLeftConstraint = tagsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 35)
        let tagsTopConstraint = tagsLabel.topAnchor.constraint(equalTo: contactHeader.bottomAnchor, constant: 15)
        scrollView.addConstraints([tagsTopConstraint, tagsLeftConstraint])
        
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        let detailsLabelLeftConstraint = detailsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let detailsLabelTopConstraint = detailsLabel.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 25)
        scrollView.addConstraints([detailsLabelLeftConstraint, detailsLabelTopConstraint])
        
        detailsTextBox.translatesAutoresizingMaskIntoConstraints = false
        let detailsLeftConstraint = detailsTextBox.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 35)
        let detailsTopConstraint = detailsTextBox.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5)
        let detailsRightConstraint = scrollView.trailingAnchor.constraint(equalTo: detailsTextBox.trailingAnchor, constant: 35)
        scrollView.addConstraints([detailsLeftConstraint, detailsTopConstraint, detailsRightConstraint])
        
        rsvpHeader.translatesAutoresizingMaskIntoConstraints = false
        let rsvpHeaderLeftConstraint = rsvpHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let rsvpHeaderTopConstraint = rsvpHeader.topAnchor.constraint(equalTo: detailsTextBox.bottomAnchor, constant: 30)
        scrollView.addConstraints([rsvpHeaderTopConstraint, rsvpHeaderLeftConstraint])
        
        rsvpBox.translatesAutoresizingMaskIntoConstraints = false
        let rsvpBoxLeftConstraint = rsvpBox.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 35)
        let rsvpBoxTopConstraint = rsvpBox.topAnchor.constraint(equalTo: rsvpHeader.bottomAnchor, constant: 10)
        scrollView.addConstraints([rsvpBoxTopConstraint, rsvpBoxLeftConstraint])
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalToConstant: 200)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: rsvpBox.bottomAnchor, constant: 15)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
        
        /*myUIPicker.translatesAutoresizingMaskIntoConstraints = false
        let pickerWidthConstraint = myUIPicker.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        let pickerBottomConstraint = myUIPicker.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        scrollView.addConstraints([pickerWidthConstraint, pickerBottomConstraint])*/
        
    }
    
    func addSubviews() {
        scrollView.addSubview(eventName)
        scrollView.addSubview(dateHeader)
        scrollView.addSubview(timeHeader)
        scrollView.addSubview(locationHeader)
        scrollView.addSubview(contactHeader)
        scrollView.addSubview(tagsLabel)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(detailsTextBox)
        scrollView.addSubview(rsvpHeader)
        scrollView.addSubview(rsvpBox)
        scrollView.addSubview(myTableView)
        //scrollView.addSubview(myUIPicker)
    }
    
    func adjustUITextViewHeight(arg: UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rsvpTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventTableViewCellVC
        // swiftlint:enable force_cast
        let rsvpType = rsvpTypes[indexPath.row]
        let rsvp = rsvps[indexPath.row]
        
        cell.rsvpTypeLabel.text = rsvpType
        cell.rsvpsLabel.text = "\(rsvp)"
        
        return cell
    }
    
    // MARK: - Navigation
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Rsvp Info")
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func edit() {
        // TODO: implement edit
    }
    
    func rsvp() {
        // TODO: implement rsvp
    }
    
    func viewRSVPs() {
        // TODO: implement view RSVPs
    }
    
    /*// data method to return the number of column shown in the picker.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    // data method to return the number of row shown in the picker.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rsvpChoices.count
    }
    
    // delegate method to return the value shown in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rsvpChoices[row] as? String
    }
    
    // delegate method called when the row was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rsvpBox.text = "\(rsvpChoices[row])"
        print("row: \(row)")
        print("value: \(rsvpChoices[row])")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }*/
}
