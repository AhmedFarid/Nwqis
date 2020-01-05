//
//  editProifleVC.swift
//  Nwqis
//
//  Created by Farido on 12/15/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class editProifleVC: UIViewController {
    
    
    @IBOutlet weak var emailTF: roundedTF!
    @IBOutlet weak var fullnameTF: roundedTF!
    @IBOutlet weak var phoneTF: roundedTF!
    @IBOutlet weak var passwordTF: roundedTF!
    @IBOutlet weak var profilImage: UIImageView!
    
    var email = ""
    var fullName = ""
    var phone = ""
    var cittid = 0
    var statId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullnameTF.text = fullName
        emailTF.text = email
        phoneTF.text = phone
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.4039215686, blue: 0.6980392157, alpha: 1)
        setUpNavColore(false)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //        navigationController?.navigationBar.barTintColor = UIColor.white
        setUpNavColore(true)
        
    }
    
    
    @IBAction func logoutBTN(_ sender: Any) {
        helperLogin.dleteAPIToken()
    }
    
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
    }
    
    func editPassword() {
    }
    
    
    
    @IBAction func uploadIamgeBTN(_ sender: Any) {
    }
    
    
    
    @IBAction func editBTN(_ sender: Any) {
        
        guard let names = fullnameTF.text, !names.isEmpty else {
                   let messages = NSLocalizedString("enter your name", comment: "hhhh")
                   let title = NSLocalizedString("Update", comment: "hhhh")
                   self.showAlert(title: title, message: messages)
                   return
               }
               
               guard let phones = phoneTF.text, !phones.isEmpty else {
                   let messages = NSLocalizedString("enter your phone", comment: "hhhh")
                   let title = NSLocalizedString("Update", comment: "hhhh")
                   self.showAlert(title: title, message: messages)
                   return
               }
        
        guard let emails = emailTF.text, !emails.isEmpty else {
            let messages = NSLocalizedString("enter your email", comment: "hhhh")
            let title = NSLocalizedString("Update", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard isValidInput(Input: names) == true else {
            self.showAlert(title: "Update", message: "Full name not correct")
            return
        }
        
        guard isValidEmail(testStr: emails) == true else {
            let messages = NSLocalizedString("email not correct", comment: "hhhh")
            let title = NSLocalizedString("Update", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        API_Prfoile.updateProfile(cityID: cittid, state_id: statId, email: emailTF.text ?? "", phone: phoneTF.text ?? "", full_name: fullnameTF.text ?? ""){(error: Error?,successConnction,success,message,errorPhone,emailError) in
            if successConnction {
                if success == true {
                    self.showAlert(title: "Update", message: "\(message ?? "")")
                }else {
                    self.showAlert(title: "Update", message: "\(errorPhone ?? "")\(emailError ?? "")")
                }
                HPGradientLoading.shared.dismiss()
            }else{
                self.showAlert(title: "Update", message: "check internet connection")
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidInput(Input:String) -> Bool {
        let myCharSet=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ أ إ  ض ص ث ق ف غ ع ه خ ح  ج د ش ي ب ل ا ت ن م ك  ط ئ ء ؤ ر لا ى ة و ز ظ")
        let output: String = Input.trimmingCharacters(in: myCharSet.inverted)
        let isValid: Bool = (Input == output)
        print("\(isValid)")
        
        return isValid
    }
}
