//
//  registerVC.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class registerVC: UIViewController {

    @IBOutlet weak var name: roundedTF!
    @IBOutlet weak var phone: roundedTF!
    @IBOutlet weak var location: roundedTF!
    @IBOutlet weak var area: roundedTF!
    @IBOutlet weak var password: roundedTF!
    @IBOutlet weak var email: roundedTF!
    override func viewDidLoad() {
        super.viewDidLoad()
            imageText()// Do any additional setup after loading the view.
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

}
