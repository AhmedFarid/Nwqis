//
//  registerVC.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class registerVC: UIViewController {
    
    @IBOutlet weak var name: roundedTF!
    @IBOutlet weak var phone: roundedTF!
    @IBOutlet weak var location: roundedTF!
    @IBOutlet weak var area: roundedTF!
    @IBOutlet weak var password: roundedTF!
    @IBOutlet weak var email: roundedTF!
    
    
    var cityId = 0
    var statusID = 0
    var city = [citysModel]()
    var status = [statesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageText()
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        createCityPiker()
        textEnabeld()
        
    }
    
    
    @objc private func handleRefreshgetcity() {
        API_CityAndAreas.getAllCity{(error: Error?, city: [citysModel]?) in
            if let city = city {
                self.city = city
                print("xxx\(self.city)")
                self.textEnabeld()
            }
        }
    }
    
    
    @objc private func handleRefreshgetStates() {
        API_CityAndAreas.getAllStates(city_id: cityId){(error: Error?, status: [statesModel]?) in
            if let status = status {
                self.status = status
                print("xxx\(self.status)")
                self.textEnabeld()
            }
        }
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(registerVC.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        location.inputAccessoryView = toolBar
        area.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func textEnabeld() {
        
        if city.isEmpty == true {
            location.isEnabled = false
        }else {
            location.isEnabled = true
        }
        
        if status.isEmpty == true {
            area.isEnabled = false
        }else{
            area.isEnabled = true
        }
    }
    
    func createCityPiker(){
        let citys = UIPickerView()
        citys.delegate = self
        citys.dataSource = self
        citys.tag = 0
        location.inputView = citys
        handleRefreshgetcity()
        citys.reloadAllComponents()
    }
    
    func createStatusPiker(){
        let stauts = UIPickerView()
        stauts.delegate = self
        stauts.dataSource = self
        stauts.tag = 1
        area.inputView = stauts
        handleRefreshgetStates()
        stauts.reloadAllComponents()
    }
    
    
    
    
    func imageText() {
        
        if let myImage = UIImage(named: "user (1)"){
            
            name.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
        if let myImage = UIImage(named: "call-answer"){
            
            phone.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
        
        if let myImage = UIImage(named: "placeholder"){
            
            location.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
        
        if let myImage = UIImage(named: "placeholder"){
            
            area.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
        
        if let myImage = UIImage(named: "Group 77"){
            
            password.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
        
        if let myImage = UIImage(named: "email"){
            
            email.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        guard let names = name.text, !names.isEmpty else {
            let messages = NSLocalizedString("enter your name", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phone.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let locations = location.text, !locations.isEmpty else {
            let messages = NSLocalizedString("enter your lcoation", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let areas = area.text, !areas.isEmpty else {
            let messages = NSLocalizedString("enter your area", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let emails = email.text, !emails.isEmpty else {
            let messages = NSLocalizedString("enter your email", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwords = password.text, !passwords.isEmpty else {
            let messages = NSLocalizedString("enter your password", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard password.text?.count ?? 0 >= 8 else {
            let messages = NSLocalizedString("password at least 8", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard isValidInput(Input: names) == true else {
            self.showAlert(title: "Register", message: "Full name not correct")
            return
        }
        
        
        guard isValidEmail(testStr: email.text ?? "") == true else {
            let messages = NSLocalizedString("email not correct", comment: "hhhh")
            let title = NSLocalizedString("Register", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        API_Auth.SignUp(fullName: names, phone: phones, city_id: "\(cityId)", state_id: "\(statusID)", password: passwords, email: emails){ (error, suces,success,emailError,phoneError)  in
            if suces {
                if success == true {
                    print("success")
                }else {
                    self.showAlert(title: "Register Fail", message: "\(emailError ?? "")\n\(phoneError ?? "")")
                }
            }else{
                self.showAlert(title: "Register Fail", message: "check internet connection")
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


extension registerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0{
            return 1
        }else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return city.count
        }else {
            return status.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            return city[row].name
        }else{
            return status[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            location.text = city[row].name
            cityId = city[row].id
            createStatusPiker()
            //self.view.endEditing(false)
        }else {
            area.text = status[row].name
            statusID = status[row].id
        }
        
    }
}
