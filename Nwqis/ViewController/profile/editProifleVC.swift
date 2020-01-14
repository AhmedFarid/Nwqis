//
//  editProifleVC.swift
//  Nwqis
//
//  Created by Farido on 12/15/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading
import MOLH

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
    var profileImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullnameTF.text = fullName
        emailTF.text = email
        phoneTF.text = phone
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
    }
    
    var picker_imag: UIImage? {
        didSet{
            guard let image = picker_imag else {return}
            profilImage.isHidden = false
            self.profilImage.image = image
        }
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
    
    
    
    @IBAction func langBTN(_ sender: Any) {
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
              //MOLH.reset(transition: .transitionCrossDissolve)
        helperLogin.restartApp()
    }
    @IBAction func uploadIamgeBTN(_ sender: Any) {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        piker.sourceType = .photoLibrary
        piker.delegate = self
        let title = NSLocalizedString("Photo Source", comment: "profuct list lang")
        let message = NSLocalizedString("Chose A Source", comment: "profuct list lang")
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let titles = NSLocalizedString("Camera", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titles, style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                piker.sourceType = .camera
                self.present(piker, animated: true, completion: nil)
            }else {
                print("notFound")
            }
        }))
        let titless = NSLocalizedString("Photo Library", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titless, style: .default, handler: { (action:UIAlertAction) in
            piker.sourceType = .photoLibrary
            self.present(piker, animated: true, completion: nil)
        }))
        let titlesss = NSLocalizedString("Cancel", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titlesss, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
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
            let messages = NSLocalizedString("Full name not correct", comment: "hhhh")
            let title = NSLocalizedString("Update", comment: "hhhh")
            self.showAlert(title: title, message: messages)
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
        
        API_Prfoile.updateProfile(cityID: cittid, state_id: statId, email: emailTF.text ?? "", phone: phoneTF.text ?? "", full_name: fullnameTF.text ?? "", image: profilImage.image ?? profileImage?.image ?? #imageLiteral(resourceName: "Group 1227")){(error: Error?,successConnction,success,message,errorPhone,emailError) in
            if successConnction {
                if success == true {
                    let title = NSLocalizedString("Update", comment: "hhhh")
                    self.showAlert(title: title, message: "\(message ?? "")")
                }else {
                    let title = NSLocalizedString("Update", comment: "hhhh")
                    self.showAlert(title: title, message: "\(errorPhone ?? "")\(emailError ?? "")")
                }
                HPGradientLoading.shared.dismiss()
            }else{
                let messages = NSLocalizedString("check internet connection", comment: "hhhh")
                let title = NSLocalizedString("Update", comment: "hhhh")
                self.showAlert(title: title, message: messages)
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

extension editProifleVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.picker_imag = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.picker_imag = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
