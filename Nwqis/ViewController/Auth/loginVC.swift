//
//  ViewController.swift
//  Nwqis
//
//  Created by Farido on 11/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices

class loginVC: UIViewController {
    
    @IBOutlet weak var emailTF: roundedTF!
    @IBOutlet weak var passwordTF: roundedTF!
    @IBOutlet weak var signWihtAppleBTN: roundedBTN!
    
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore()
        imageText()
        setupViewAppleBTN()
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        
    }
    
    func setUpNavColore(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    func setupViewAppleBTN() {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        view.addSubview(appleButton)
        //appleButton.layer.cornerRadius = appleButton.layer.bounds.height / 2
        NSLayoutConstraint.activate([
            appleButton.centerYAnchor.constraint(equalTo: signWihtAppleBTN.centerYAnchor),
            appleButton.centerXAnchor.constraint(equalTo: signWihtAppleBTN.centerXAnchor),
            appleButton.widthAnchor.constraint(equalTo: signWihtAppleBTN.widthAnchor),
            appleButton.heightAnchor.constraint(equalTo: signWihtAppleBTN.heightAnchor),
        ])
    }
    
    @objc func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    
    
    func imageText() {
        
        if let myImage = UIImage(named: "email"){
            
            emailTF.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
        }
//        if let myImage = UIImage(named: "Group 77"){
//
//            passwordTF.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0.1241763458, green: 0.3040906787, blue: 0.5637683272, alpha: 1))
//        }
    }
    
    
    @IBAction func fbLoginBTN(_ sender: Any) {
        
        let fbdLoginManager: LoginManager = LoginManager()
        fbdLoginManager.logIn(permissions: ["email"], from: self){ (result,error) in
            if (error == nil) {
                let fbLoginResult: LoginManagerLoginResult = result!
                if fbLoginResult.grantedPermissions != nil {
                    if(fbLoginResult.grantedPermissions.contains("email")) {
                        self.GetFBUserData()
                        fbdLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogout(_ loginButoon: FBLoginButton!) {
        print("user Logout")
    }
    
    func GetFBUserData() {
        if((AccessToken.current) != nil) {
            GraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler:{(connection, result, error)-> Void in
                if (error == nil) {
                    let faceDic = result as! [String: AnyObject]
                    print(faceDic)
                    let email = faceDic["email"] as! String
                    print(email)
                    let id = faceDic["id"] as! String
                    print(id)
                    let fname = faceDic["first_name"] as! String
                    print(fname)
                    let lname = faceDic["last_name"] as! String
                    print(lname)
                    if id != "" {
                        
                        HPGradientLoading.shared.configation.fromColor = .white
                        HPGradientLoading.shared.configation.toColor = .blue
                        HPGradientLoading.shared.showLoading(with: "Loading...")
                        
                        API_Auth.FBLogin(full_name: "\(fname) \(lname)", email: email, social_id: id){ (error, suces,success) in
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
            })
        }
    }
    
    
    
    @IBAction func showPasswordBTN(_ sender: Any) {
        passwordTF.isSecureTextEntry.toggle()

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

extension loginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = User(credentials: credentials)
            print(user)
            HPGradientLoading.shared.configation.fromColor = .white
            HPGradientLoading.shared.configation.toColor = .blue
            HPGradientLoading.shared.showLoading(with: "Loading...")
            API_Auth.FBLogin(full_name: "\(user.firstName) \(user.lastName)", email: user.email, social_id: user.id){ (error, suces,success) in
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
        //performSegue(withIdentifier: "segue", sender: user)
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error", error)
    }
}

extension loginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
