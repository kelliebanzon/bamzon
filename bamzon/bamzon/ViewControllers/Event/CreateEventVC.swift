//
//  CreateEventVC.swift
//  bamzon
//
//  Created by Brandon Ryan on 17.03.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController, UITextFieldDelegate, DisplayableProtocol, RefreshableProtocol {
    
    var nameLabel = UILabel()
    var nameTextField = UITextField()
    var descLabel = UILabel()
    var locLabel = UILabel()
    var dateLabel = UILabel()
    var timeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        nameLabel = createDefaultLabel(text: "Event Name", fontSize: 20, numLines: 0, fontColor: .white, fontAlignment: .left)
        nameTextField.borderStyle = .line
        nameTextField.keyboardType = .default
        nameTextField.placeholder = "Enter event name"
        nameTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        nameTextField.delegate = self
        
        addSubviews()
        setupAutoLayout()
    }
    
    func addSubviews() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameTextField)
    }
    
    func setupAutoLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameTopConstraint = nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70)
        let nameLeftConstraint = nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        self.view.addConstraints([nameTopConstraint, nameLeftConstraint])
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        let nameTextLeftConstraint = nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5)
        let nameTextRightConstraint = nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        let nameTextBottomConstraint = nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        let nameTextHeightConstraint = nameTextField.heightAnchor.constraint(equalToConstant: 18)
        self.view.addConstraints([nameTextLeftConstraint, nameTextRightConstraint, nameTextBottomConstraint, nameTextHeightConstraint])
    }
    
    func refresh() {

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
