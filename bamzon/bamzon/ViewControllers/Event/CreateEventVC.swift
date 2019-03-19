//
//  CreateEventVC.swift
//  bamzon
//
//  Created by Brandon Ryan on 17.03.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController, UITextFieldDelegate, DisplayableProtocol, RefreshableProtocol {
   
    @IBOutlet weak var dateText: UITextField!
    
    let createEventVM = CreateEventVM()
    var nameLabel = UILabel()
    var nameTextField = UITextField()
    var descLabel = UILabel()
    var descTextView = UITextView() // change to text view
    var locLabel = UILabel()
    var locTextField = UITextField()
    var dateLabel = UILabel()
    var date = Date()
    var contactLabel = UILabel()
    var contactText = UITextField()
    var submitButton = UIButton()

    var timeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        nameLabel = createDefaultLabel(text: "Event Name", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        descLabel = createDefaultLabel(text: "Event Description", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        
        nameTextField = createTextFieldToConstrain(withText: "Enter event name")
        nameTextField.delegate = self
        
        descTextView.textAlignment = .left
        descTextView.backgroundColor = .white
        descTextView.layer.cornerRadius = 10
        descTextView.font = UIFont(name: "HelveticaNeue", size: 17)
        descTextView.textColor = .black
        descTextView.isEditable = true
        
        locLabel = createDefaultLabel(text: "Event Location", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        locTextField = createTextFieldToConstrain(withText: "Enter location")
        
        dateLabel = createDefaultLabel(text: "Event Date", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        dateText.attributedPlaceholder = NSAttributedString(string: "Select Date", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSLightGray")!])
        dateText.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        
        //datepicker
        createDatePicker()
        createToolbar()
        
        contactLabel = createDefaultLabel(text: "Event Contact", fontSize: 18, numLines: 0, fontColor: .white, fontAlignment: .left)
        contactText = createTextFieldToConstrain(withText: "Enter Contact Name")
        
        submitButton = createButtonToConstrain(withText: "Create Event", size: 20)
        submitButton.addTarget(self, action: #selector(createEvent), for: [.touchUpOutside, .touchUpInside])
        
        //adjustUITextViewHeight(arg: descTextView)
        //descTextView.delegate = self
        
        addSubviews()
        setupAutoLayout()
    }
    
    func addSubviews() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameTextField)
        self.view.addSubview(descLabel)
        self.view.addSubview(descTextView)
        self.view.addSubview(locLabel)
        self.view.addSubview(locTextField)
        self.view.addSubview(dateLabel)
        self.view.addSubview(dateText)
        self.view.addSubview(submitButton)
        self.view.addSubview(contactLabel)
        self.view.addSubview(contactText)
    }
    
    func setupAutoLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameTopConstraint = nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70)
        let nameLeftConstraint = nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        self.view.addConstraints([nameTopConstraint, nameLeftConstraint])
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        let nameTextLeftConstraint = nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 2)
        let nameTextRightConstraint = nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let nameTextBottomConstraint = nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
        let nameTextHeightConstraint = nameTextField.heightAnchor.constraint(equalToConstant: 30)
        let nameTextWidthConstraint = nameTextField.widthAnchor.constraint(equalToConstant: 200)
        self.view.addConstraints([nameTextLeftConstraint, nameTextRightConstraint, nameTextBottomConstraint, nameTextHeightConstraint, nameTextWidthConstraint])
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        let descTopConstraint = descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        let descLeftConstraint = descLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        self.view.addConstraints([descTopConstraint, descLeftConstraint])
        
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        let descTextLeftConstraint = descTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let descTextRightConstraint = descTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let descTextHeightConstraint = descTextView.heightAnchor.constraint(equalToConstant: 53)
        let descTextTopConstraint = descTextView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5)
        self.view.addConstraints([descTextLeftConstraint, descTextRightConstraint, descTextHeightConstraint, descTextTopConstraint])
        
        locLabel.translatesAutoresizingMaskIntoConstraints = false
        let locTopConstraint = locLabel.topAnchor.constraint(equalTo: descTextView.bottomAnchor, constant: 20)
        let locLeftConstraint = locLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        self.view.addConstraints([locTopConstraint, locLeftConstraint])
        
        locTextField.translatesAutoresizingMaskIntoConstraints = false
        let locTextLeftConstraint = locTextField.leadingAnchor.constraint(equalTo: locLabel.trailingAnchor, constant: 2)
        let locTextRightConstraint = locTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let locTextBottomConstraint = locTextField.bottomAnchor.constraint(equalTo: locLabel.bottomAnchor, constant: 5)
        let locTextHeightConstraint = locTextField.heightAnchor.constraint(equalToConstant: 30)
        let locTextWidthConstraint = locTextField.widthAnchor.constraint(equalToConstant: 200)
        self.view.addConstraints([locTextLeftConstraint, locTextRightConstraint, locTextBottomConstraint, locTextHeightConstraint, locTextWidthConstraint])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateTopConstraint = dateLabel.topAnchor.constraint(equalTo: locTextField.bottomAnchor, constant: 20)
        let dateLeftConstraint = dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        self.view.addConstraints([dateTopConstraint, dateLeftConstraint])
        
        dateText.translatesAutoresizingMaskIntoConstraints = false
        let dateTextRightConstraint = dateText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let dateTextBottomConstraint = dateText.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5)
        let dateTextWidthConstraint = dateText.widthAnchor.constraint(equalToConstant: 200)
        self.view.addConstraints([dateTextRightConstraint, dateTextBottomConstraint, dateTextWidthConstraint])
        
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        let contactTopConstraint = contactLabel.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 20)
        let contactLeftConstraint = contactLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        self.view.addConstraints([contactTopConstraint, contactLeftConstraint])
        
        contactText.translatesAutoresizingMaskIntoConstraints = false
        let contactTextRightConstraint = contactText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let contactTextBottomConstraint = contactText.bottomAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 5)
        let contactTextWidthConstraint = contactText.widthAnchor.constraint(equalToConstant: 200)
        let contactTextHeightConstraint = contactText.heightAnchor.constraint(equalToConstant: 30)
        self.view.addConstraints([contactTextRightConstraint, contactTextBottomConstraint, contactTextWidthConstraint, contactTextHeightConstraint])
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        let submitRightConstraint = submitButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let submitTopConstraint = submitButton.topAnchor.constraint(equalTo: contactText.bottomAnchor, constant: 30)
        let submitWidthConstraint = submitButton.widthAnchor.constraint(equalToConstant: 120)
        self.view.addConstraints([submitRightConstraint, submitTopConstraint, submitWidthConstraint])

    }
    
    func refresh() {

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func createDatePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(CreateEventVC.datePickerValueChanged(_:)), for: .valueChanged)
        dateText.inputView = datePicker
        
        //Customizations
        datePicker.backgroundColor = .white
        datePicker.timeZone = NSTimeZone.local
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()

        // Set date format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm Z"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        date = Date.fromString(from: selectedDate)
    
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CreateEventVC.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dateText.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func createEvent() {
        
       // contact_name = contactText.text
        //don't know how to make ID out of it
        //location  = locationText.text, need to make actual Location
        let eventID = IDUtility.generateEventID()
        

        let event = Event(eventID: eventID, teamID: createEventVM.team.teamID, name: nameTextField.text!, locationID: nil, contactUserIDs: [:], description: descTextView.text, date: date, tags: [:], media: [:], links: [:])
        
        createDBEvent(event: event)
    }
    
    func createDBEvent(event: Event) {
        DBUtility.writeToDB(objToWrite: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
