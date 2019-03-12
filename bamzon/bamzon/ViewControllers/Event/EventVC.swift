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

class EventVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {
    
    @IBOutlet weak var rsvpBox: UITextField!
    
    let rsvpPickerTypes = ["Yes",
                "No",
                "Maybe",
                "Pending"]
    var selectedType: String?
    
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
        createRsvpPicker()
        createToolbar()
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
        dateLabel = createDefaultLabel(text: "event_date", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        timeHeader = createDefaultLabel(text: "Time: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        timeLabel = createDefaultLabel(text: "event_time", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        timeLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        locationHeader = createDefaultLabel(text: "Location: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        locationLabel = createDefaultLabel(text: "event_location", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        locationLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        contactHeader = createDefaultLabel(text: "Contact: ", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        contactLabel = createDefaultLabel(text: "event_contact", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        contactLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        tagsLabel = createDefaultLabel(text: "Tags: ", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        detailsLabel = createDefaultLabel(text: "Details", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        detailsTextBox.textAlignment = .left
        detailsTextBox.font = UIFont(name: "HelveticaNeue", size: 17)
        detailsTextBox.text = "This is an example bio This is an example bioThis is an example bioThis is an example bioThis is an example bioThis is an example bioThis is an example bioThis is an example bio"
        detailsTextBox.textColor = .white
        detailsTextBox.isEditable = false
        detailsTextBox.backgroundColor = UIColor(named: "TSTeal")
        adjustUITextViewHeight(arg: detailsTextBox)
        rsvpHeader = createDefaultLabel(text: "RSVP", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        /*rsvpBox.leftViewMode = .always
        rsvpBox.attributedPlaceholder = NSAttributedString(string: "Going?", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        rsvpBox.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        rsvpBox.textColor = .white
        */
        addSubviews()
    }    
    
    func setupAutoLayout() {
        eventName.translatesAutoresizingMaskIntoConstraints = false
        let nameHorizConstraint = eventName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let nameTopConstraint = eventName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70)
        let nameLeftConstraint = eventName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let nameRightConstraint = scrollView.trailingAnchor.constraint(equalTo: eventName.trailingAnchor, constant: 30)
        scrollView.addConstraints([nameTopConstraint, nameHorizConstraint, nameLeftConstraint, nameRightConstraint])
        
        dateHeader.translatesAutoresizingMaskIntoConstraints = false
        let dateHeaderLeftConstraint = dateHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let dateHeaderTopConstraint = dateHeader.topAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 40)
        scrollView.addConstraints([dateHeaderTopConstraint, dateHeaderLeftConstraint])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateleftConstraint = dateLabel.leadingAnchor.constraint(equalTo: dateHeader.trailingAnchor, constant: 10)
        let dateBottomConstraint = dateLabel.bottomAnchor.constraint(equalTo: dateHeader.bottomAnchor)
        scrollView.addConstraints([dateleftConstraint, dateBottomConstraint])
        
        timeHeader.translatesAutoresizingMaskIntoConstraints = false
        let timeHeaderLeftConstraint = timeHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let timeHeaderTopConstraint = timeHeader.topAnchor.constraint(equalTo: dateHeader.bottomAnchor, constant: 10)
        scrollView.addConstraints([timeHeaderLeftConstraint, timeHeaderTopConstraint])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let timeleftConstraint = timeLabel.leadingAnchor.constraint(equalTo: timeHeader.trailingAnchor, constant: 10)
        let timeBottomConstraint = timeLabel.bottomAnchor.constraint(equalTo: timeHeader.bottomAnchor)
        scrollView.addConstraints([timeleftConstraint, timeBottomConstraint])
        
        locationHeader.translatesAutoresizingMaskIntoConstraints = false
        let locHeaderLeftConstraint = locationHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let locHeaderTopConstraint = locationHeader.topAnchor.constraint(equalTo: timeHeader.bottomAnchor, constant: 10)
        scrollView.addConstraints([locHeaderLeftConstraint, locHeaderTopConstraint])
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        let locationleftConstraint = locationLabel.leadingAnchor.constraint(equalTo: locationHeader.trailingAnchor, constant: 10)
        let locationBottomConstraint = locationLabel.bottomAnchor.constraint(equalTo: locationHeader.bottomAnchor)
        scrollView.addConstraints([locationleftConstraint, locationBottomConstraint])
        
        contactHeader.translatesAutoresizingMaskIntoConstraints = false
        let contactHeaderLeftConstraint = contactHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let contactHeaderTopConstraint = contactHeader.topAnchor.constraint(equalTo: locationHeader.bottomAnchor, constant: 10)
        scrollView.addConstraints([contactHeaderLeftConstraint, contactHeaderTopConstraint])
        
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        let contactLeftConstraint = contactLabel.leadingAnchor.constraint(equalTo: contactHeader.trailingAnchor, constant: 10)
        let contactBottomConstraint = contactLabel.bottomAnchor.constraint(equalTo: contactHeader.bottomAnchor)
        scrollView.addConstraints([contactLeftConstraint, contactBottomConstraint])
        
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        let tagsLeftConstraint = tagsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30)
        let tagsTopConstraint = tagsLabel.topAnchor.constraint(equalTo: contactHeader.bottomAnchor, constant: 10)
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
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(timeHeader)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(locationHeader)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(contactHeader)
        scrollView.addSubview(contactLabel)
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
    
    func createRsvpPicker() {
        
        let rsvpPicker = UIPickerView()
        rsvpPicker.delegate = self
        rsvpPicker.translatesAutoresizingMaskIntoConstraints = false
        
        rsvpBox.inputView = rsvpPicker
        
        //Customizations
        rsvpPicker.backgroundColor = .white
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(EventVC.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        rsvpBox.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rsvpPickerTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rsvpPickerTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = rsvpPickerTypes[row]
        rsvpBox.text = selectedType
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        
        label.text = rsvpPickerTypes[row]
        
        return label
    }
    
}
