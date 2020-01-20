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
import GoogleSignIn
import SafariServices

class loginVC: UIViewController,SFSafariViewControllerDelegate {
    
    @IBOutlet weak var signGooleBtn: GIDSignInButton!
    @IBOutlet weak var emailTF: roundedTF!
    @IBOutlet weak var passwordTF: roundedTF!
    @IBOutlet weak var signWihtAppleBTN: roundedBTN!
    
    var user: User?
    var googleSignIn = GIDSignIn.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().signOut()
        setUpNavColore()
        imageText()
        setupViewAppleBTN()
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
    }
    
    
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginAsCompany(_ sender: Any) {
        let safariVC = SFSafariViewController(url: NSURL(string:"http://nwqis.com/company/login")! as URL)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    @IBAction func loginAsShop(_ sender: Any) {
        let safariVC = SFSafariViewController(url: NSURL(string:"http://nwqis.com/shop/login")! as URL)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }

    func setUpNavColore(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupViewAppleBTN() {
        let customAppleLoginBtn = UIButton()
        customAppleLoginBtn.layer.cornerRadius = 25
        customAppleLoginBtn.backgroundColor = UIColor.black
        customAppleLoginBtn.setImage(UIImage(named: "apple"), for: .normal)
        customAppleLoginBtn.imageEdgeInsets = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        customAppleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        customAppleLoginBtn.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        view.addSubview(customAppleLoginBtn)
        NSLayoutConstraint.activate([
            customAppleLoginBtn.centerYAnchor.constraint(equalTo: signWihtAppleBTN.centerYAnchor),
            customAppleLoginBtn.centerXAnchor.constraint(equalTo: signWihtAppleBTN.centerXAnchor),
            customAppleLoginBtn.widthAnchor.constraint(equalTo: signWihtAppleBTN.widthAnchor),
            customAppleLoginBtn.heightAnchor.constraint(equalTo: signWihtAppleBTN.heightAnchor),
        ])
    }
    
    
    @IBAction func googleACtion(_ sender: Any) {
        self.googleAuthLogin()
    }
    
    func googleAuthLogin() {
        self.googleSignIn?.presentingViewController = self
        self.googleSignIn?.clientID = "653758592339-ce527lg3q076vl82driquqorahlgph36.apps.googleusercontent.com"
        self.googleSignIn?.delegate = self
        self.googleSignIn?.signIn()
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
                                    let message = NSLocalizedString("Email or passwod Wrong", comment: "hhhh")
                                    let title = NSLocalizedString("Login Fail", comment: "hhhh")
                                    self.showAlert(title: title, message: message)
                                }
                            }else{
                                let message = NSLocalizedString("check internet connection", comment: "hhhh")
                                let title = NSLocalizedString("Login Fail", comment: "hhhh")
                                self.showAlert(title: title, message: message)
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
                    let message = NSLocalizedString("Email or passwod Wrong", comment: "hhhh")
                    let title = NSLocalizedString("Login Fail", comment: "hhhh")
                    self.showAlert(title: title, message: message)
                }
            }else{
                let message = NSLocalizedString("check internet connection", comment: "hhhh")
                let title = NSLocalizedString("Login Fail", comment: "hhhh")
                self.showAlert(title: title, message: message)
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
                        let message = NSLocalizedString("Email or passwod Wrong", comment: "hhhh")
                        let title = NSLocalizedString("Login Fail", comment: "hhhh")
                        self.showAlert(title: title, message: message)
                    }
                }else{
                    let message = NSLocalizedString("check internet connection", comment: "hhhh")
                    let title = NSLocalizedString("Login Fail", comment: "hhhh")
                    self.showAlert(title: title, message: message)
                }
                HPGradientLoading.shared.dismiss()
            }
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
extension loginVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard let user = user else {
            print("Uh oh. The user cancelled the Google login.")
            return
        }
        let userId = user.userID ?? ""
        print("Google User ID: \(userId)")
        
        let userIdToken = user.authentication.idToken ?? ""
        print("Google ID Token: \(userIdToken)")
        
        let userFirstName = user.profile.givenName ?? ""
        print("Google User First Name: \(userFirstName)")
        
        let userLastName = user.profile.familyName ?? ""
        print("Google User Last Name: \(userLastName)")
        
        let userEmail = user.profile.email ?? ""
        print("Google User Email: \(userEmail)")
        
        let googleProfilePicURL = user.profile.imageURL(withDimension: 150)?.absoluteString ?? ""
        print("Google Profile Avatar URL: \(googleProfilePicURL)")
        
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        API_Auth.FBLogin(full_name: "\(userFirstName) \(userLastName)", email: userEmail, social_id: userId){ (error, suces,success) in
            if suces {
                if success == true {
                    print("success")
                }else {
                    let message = NSLocalizedString("Email or passwod Wrong", comment: "hhhh")
                    let title = NSLocalizedString("Login Fail", comment: "hhhh")
                    self.showAlert(title: title, message: message)
                }
            }else{
                let message = NSLocalizedString("check internet connection", comment: "hhhh")
                let title = NSLocalizedString("Login Fail", comment: "hhhh")
                self.showAlert(title: title, message: message)
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("User has disconnected")
    }
}
