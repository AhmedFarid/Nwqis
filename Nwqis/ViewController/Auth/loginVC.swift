//
//  ViewController.swift
//  Nwqis
//
//  Created by Farido on 11/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class loginVC: UIViewController {
    
    @IBOutlet weak var emailTF: roundedTF!
    @IBOutlet weak var passwordTF: roundedTF!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore()
        imageText()
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
    }
    
    func setUpNavColore(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    func imageText() {
        
        if let myImage = UIImage(named: "email"){
            
            emailTF.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
        if let myImage = UIImage(named: "Group 77"){
            
            passwordTF.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
    }
    @IBAction func loginBTN(_ sender: Any) {
        
        guard let emails = emailTF.text, !emails.isEmpty else {
            let messages = NSLocalizedString("enter your email", comment: "hhhh")
            let title = NSLocalizedString("login", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwords = passwordTF.text, !passwords.isEmpty else {
            let messages = NSLocalizedString("enter your password", comment: "hhhh")
            let title = NSLocalizedString("login", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        API_Auth.Login(email: emails, password: passwords){ (error, suces,success)  in
            if suces {
            if success == true {
                print("success")
            }else {
                self.showAlert(title: "Login Fail", message: "Email or passwod Wrong")
                }
            }else{
                self.showAlert(title: "Login Fail", message: "check internet connection")
            }
            HPGradientLoading.shared.dismiss()
        }
    }
}	

