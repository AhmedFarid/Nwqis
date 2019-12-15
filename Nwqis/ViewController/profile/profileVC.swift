//
//  profileVC.swift
//  Nwqis
//
//  Created by Farido on 12/15/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class profileVC: UIViewController {

    @IBOutlet weak var emailLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    
    
    var email = ""
    var phone = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleRefreshgetProfile()
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleRefreshgetProfile()
    }
    
    @IBAction func settingBTN(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? editProifleVC{
            destaiantion.email = email
            destaiantion.fullName = name
            destaiantion.phone = phone
        }
    }
        
    @objc private func handleRefreshgetProfile() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        API_Prfoile.getMyProfile{(error: Error?,successConnction,success,full_name,email,phone) in
            if success == true {
                self.emailLb.text = email
                self.nameLb.text = full_name
                self.email = email ?? ""
                self.phone = phone ?? ""
                self.name = full_name ?? ""
            }else {
                self.showAlert(title: "Internet Connection", message: "check internet connection")
            }
            HPGradientLoading.shared.dismiss()
        }
    }
}
