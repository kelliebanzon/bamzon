//
//  CreateAccountPromptCodeVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/07/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateAccountPromptCodeVC: UIViewController, DisplayableProtocol, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        // Do any additional setup after loading the view.
    }
    
    func display(){
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 120))
        tempLabel.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        tempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 1
        tempLabel.textColor = .white
        tempLabel.text = "CreateAccountPromptCodeVC"
        self.view.addSubview(tempLabel)
    }
    
//    @ kyle: when you're ready to transition to the account success creation page,
//    add this line of code to your function:
//    let nextVC = storyboard!.instantiateViewController(withIdentifier: "CreateAccountSuccessVC")
//    present(nextVC, animated: true, completion: nil)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
