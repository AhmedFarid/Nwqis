//
//  ViewController.swift
//  Nwqis
//
//  Created by Farido on 11/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var emailTF: roundedTF!
    @IBOutlet weak var passwordTF: roundedTF!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore()
        imageText()
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


}

