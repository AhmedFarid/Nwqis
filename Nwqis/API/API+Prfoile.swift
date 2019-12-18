//
//  API+Prfoile.swift
//  Nwqis
//
//  Created by Farido on 12/15/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Prfoile: NSObject {
    
    class func getMyProfile(completion: @escaping (_ error: Error?, _ success: Bool,_ successs: Bool?, _ full_name: String?, _ email: String?, _ phone: String?)->Void) {
        
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,false,false,nil,nil,nil)
            return
        }
        
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        
        let url = URLs.userProfile
        print(url)
        
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: headers) .responseJSON { response in
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
                    let full_name = json["data"]["full_name"].string
                    let email = json["data"]["email"].string
                    let phone = json["data"]["phone"].string
                    completion(nil,true,success,full_name,email,phone)
                }
            }
        }
    }
    
    class func updateProfile(email: String,phone: String,full_name: String,completion: @escaping (_ error: Error?, _ success: Bool,_ successs: Bool?,_ message: String?,_ phoneError: String?,_ emailError: String?)->Void) {
           
           
           guard let user_token = helperLogin.getAPIToken() else {
               completion(nil,false,false,nil,nil,nil)
               return
           }
           
           let lang = NSLocalizedString("en", comment: "profuct list lang")
           
           let url = URLs.editProfile
           print(url)
        
        let parameters = [
            "email": email,
            "phone": phone,
            "full_name": full_name,
            "city_id": "1",
            "state_id": "1",
            "lat": "",
            "lng": ""
        ]
           
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
    
    class func getOffers(category_id: String,completion: @escaping (_ error: Error?,_ categours: [offersModel]?,_ success: Bool?)-> Void) {
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,nil,false)
            return
        }
        
        let url = URLs.offers
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        
        let parameters = [
            "category_id": category_id
        ]
        
        print(parameters)
        
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil, false)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                let success = json["success"].bool
                if success == true {
                    guard let dataArray = json["data"].array else{
                        completion(nil, nil,success)
                        return
                    }
                    print(dataArray)
                    var products = [offersModel]()
                    for data in dataArray {
                        if let data = data.dictionary, let prodect = offersModel.init(dict: data){
                            products.append(prodect)
                        }
                    }
                    completion(nil, products,success)
                }
            }
        }
    }
}
