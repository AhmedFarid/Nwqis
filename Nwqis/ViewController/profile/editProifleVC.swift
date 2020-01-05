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
    
    
    
    @IBAction func uploadIamgeBTN(_ sender: Any) {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        piker.sourceType = .photoLibrary
        piker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Chose A Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                piker.sourceType = .camera
                self.present(piker, animated: true, completion: nil)
            }else {
                print("notFound")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            piker.sourceType = .photoLibrary
            self.present(piker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
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
        
        API_Prfoile.updateProfile(cityID: cittid, state_id: statId, email: emailTF.text ?? "", phone: phoneTF.text ?? "", full_name: fullnameTF.text ?? "", image: profilImage.image ?? profileImage?.image ?? #imageLiteral(resourceName: "Group 1227")){(error: Error?,successConnction,success,message,errorPhone,emailError) in
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
