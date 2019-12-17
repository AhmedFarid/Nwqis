//
//  API+Requests.swift
//  Nwqis
//
//  Created by Farido on 12/17/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Requests: NSObject {

    class func addRequest(description: String,city_id: String,state_id: String,lat: String,lng: String,category_id:String,subcategory_id:String ,completion: @escaping (_ error: Error?, _ success: Bool,_ successs: Bool?,_ message: String?,_ phoneError: String?,_ emailError: String?)->Void) {
        
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,false,false,nil,nil,nil)
            return
        }
        
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        
        let url = URLs.addShortList
        print(url)
     
     let parameters = [
         "description": description,
         "city_id": city_id,
         "state_id": state_id,
         "lat": lat,
         "lng": lng,
         "category_id": category_id,
         "subcategory_id": subcategory_id
     ]
        
        print(parameters)
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil,nil,nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                let success = json["success"].bool
                if success == true {
                 let meesage = json["message"].string
                 completion(nil,true,success,meesage,nil,nil)
                }else {
                 if let emailError = json["data"]["email"][0].string {
                     completion(nil,true,success,nil,nil,emailError)
                 }
                 if let phoneError = json["data"]["phone"][0].string {
                     completion(nil,true,success,nil,phoneError,nil)
                 }
             }
            }
        }
    }
    
}
