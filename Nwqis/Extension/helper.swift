//
//  helper.swift
//  Nwqis
//
//  Created by Farido on 11/27/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import Foundation
import UIKit
import HPGradientLoading

class helperAddress: NSObject {
    
    
    class func deleteOldAddreess() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "city")
        def.removeObject(forKey: "area")
        def.removeObject(forKey: "zone")
        def.removeObject(forKey: "streetAddresss")
        def.removeObject(forKey: "lat")
        def.removeObject(forKey: "long")
        def.synchronize()
    }
    
    class func saveNewAddress(city: String,area: String,zone: String, streetAddresss: String, lat: String, long: String) {
        let def = UserDefaults.standard
        def.setValue(city, forKey: "city")
        def.setValue(area, forKey: "area")
        def.setValue(zone, forKey: "zone")
        def.setValue(streetAddresss, forKey: "streetAddresss")
        def.setValue(lat, forKey: "lat")
        def.setValue(long, forKey: "long")
        def.synchronize()
    }
    
    class func getAddresss() -> (city: String?,area: String?, zone: String?, streetAddresss: String?, lat: String?, long: String?) {
        let def = UserDefaults.standard
        return (def.object(forKey: "city") as? String,def.object(forKey: "area") as? String,def.object(forKey: "zone") as? String,def.object(forKey: "streetAddresss") as? String,def.object(forKey: "lat") as? String,def.object(forKey: "long") as? String)
    }
}

class Spiner: NSObject {
    class func addSpiner(isEnableDismiss: Bool, isBulurBackgroud: Bool, isBlurLoadin: Bool, durationAnimation: Double, fontSize: Int){
        HPGradientLoading.shared.configation.isEnableDismissWhenTap = isEnableDismiss //fasle
        HPGradientLoading.shared.configation.isBlurBackground = isBulurBackgroud //true
        HPGradientLoading.shared.configation.isBlurLoadingActivity = isBlurLoadin //true
        HPGradientLoading.shared.configation.durationAnimation = durationAnimation // 1.5
        HPGradientLoading.shared.configation.fontTitleLoading = UIFont.systemFont(ofSize: CGFloat(fontSize)) //20
    }
}

class helperLogin: NSObject {
    
    class func restartApp(){
       guard let window = UIApplication.shared.keyWindow else {return}
            let sb = UIStoryboard(name: "Main", bundle: nil)
            var vc: UIViewController
            if getAPIToken() == nil {
                vc = sb.instantiateInitialViewController()!
            }else {
                vc = sb.instantiateViewController(withIdentifier: "Home")
            }
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        }
    
    class func dleteAPIToken() {
           let def = UserDefaults.standard
           def.removeObject(forKey: "user_token")
           def.synchronize()
           
           restartApp()
       }
    
    class func saveAPIToken(token: String) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "user_token")
        def.synchronize()
        
        restartApp()
    }
    
    class func getAPIToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_token") as? String
    }
}
