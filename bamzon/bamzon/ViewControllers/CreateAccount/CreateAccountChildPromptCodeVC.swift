//
//  CreateAccountChildPromptCodeVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/07/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateAccountChildPromptCodeVC: UIViewController, DisplayableProtocol, UITextFieldDelegate {

    var code: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        // Do any additional setup after loading the view.
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        let codePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 30, width: 400, height: 120))
        tempLabel.center = CGPoint(x: view.frame.midX, y: 150)
        tempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 0
        tempLabel.textColor = .white
        tempLabel.text = "Please enter the security code \remailed to [EMAIL]"
        self.view.addSubview(tempLabel)
        
        // Security Code
        code = UITextField(frame: CGRect(x: 20, y: 240, width: 340, height: 35))
        code?.center = CGPoint(x: view.frame.midX, y: view.frame.midY - 35)
        code?.leftView = codePaddingView
        code?.leftViewMode = .always
        code?.attributedPlaceholder = NSAttributedString(string: "Security Code", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        code?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        code?.textColor = .white
        self.view.addSubview(code!)
        
        let codeBar = CAShapeLayer()
        codeBar.path = UIBezierPath(roundedRect: CGRect(x: 20, y: view.frame.midY - 15, width: view.frame.width - 40, height: 2), cornerRadius: 8).cgPath
        codeBar.fillColor = UIColor.white.cgColor
        self.view.layer.addSublayer(codeBar)
        
        // Verify Button
        let verify = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        verify.center = CGPoint(x: view.center.x, y: view.frame.midY + 35)
        verify.setTitle("Verify", for: .normal)
        verify.backgroundColor = UIColor(named: "TSYellow")
        verify.layer.shadowColor = UIColor.black.cgColor
        verify.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        verify.layer.masksToBounds = false
        verify.layer.shadowRadius = 1.0
        verify.layer.shadowOpacity = 0.5
        verify.layer.cornerRadius = 8
        verify.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        verify.addTarget(self, action: #selector(verifyCode), for: .touchUpInside)
        //verify.addTarget(self, action: #selector(highlightverify), for: .touchDown)
        //verify.addTarget(self, action: #selector(unhighlightverify), for: [.touchUpOutside, .touchUpInside])
        self.view.addSubview(verify)
    }
    
    // Function call to VM to verify code
    @objc func verifyCode() {
        if code?.text == "123456" {
            let nextVC = storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildSuccessVC")
            present(nextVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Uh oh!", message: "That code doesn't look right 😰\rPlease try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//    @ kyle: when you're ready to transition to the account success creation page,
//    add this line of code to your function:

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
