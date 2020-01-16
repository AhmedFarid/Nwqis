//
//  loginAndRegesterWebViewVC.swift
//  Nwqis
//
//  Created by Farido on 1/16/20.
//  Copyright © 2020 Farido. All rights reserved.
//

import UIKit
import SafariServices

class loginAndRegesterWebViewVC: UIViewController,SFSafariViewControllerDelegate  {

    //@IBOutlet weak var loginWeKIT: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        loginWeKIT.uiDelegate = self
//        let myURL = URL(string:"https://www.apple.com")
//        let myRequest = URLRequest(url: myURL!)
//        loginWeKIT.load(myRequest)
        let safariVC = SFSafariViewController(url: NSURL(string:"https://www.apple.com")! as URL)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
       override func viewWillAppear(_ animated: Bool) {
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.4039215686, blue: 0.6980392157, alpha: 1)
            setUpNavColore(false)
            
        }
        
        
        override func viewWillDisappear(_ animated: Bool) {
    //        navigationController?.navigationBar.barTintColor = UIColor.white
            setUpNavColore(true)
            
        }
        
        
        func setUpNavColore(_ isTranslucent: Bool){
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = isTranslucent
        }
}
