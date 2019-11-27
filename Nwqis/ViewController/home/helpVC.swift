//
//  helpVC.swift
//  Nwqis
//
//  Created by Farido on 11/24/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class helpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.green
        
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
