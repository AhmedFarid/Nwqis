//
//  API+Auth.swift
//  Nwqis
//
//  Created by Farido on 12/10/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Auth: NSObject {
    
    class func Login(email:String,password: String, completion: @escaping (_ error: Error?, _ success: Bool, _ status: Bool?)->Void) {
        
        let url = URLs.Login
        print(url)
        let parameters = [
            "email": email,
            "password": password,
            "remember_me": true
            ] as [String : Any]
        
        let headers = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let access_token = json["access_token"].string {
                    print("user token \(access_token)")
                    helperLogin.saveAPIToken(token: access_token)
                    completion(nil, true,false)
                }else {
                    let success = json["success"].bool
                    print(success ?? "no")
                    completion(nil,true,success)
                }
                
            }
        }
        
    }
    
    class func FBLogin(social_id:String, completion: @escaping (_ error: Error?, _ success: Bool, _ status: Bool?)->Void) {
        
        let url = URLs.socialLogin
        print(url)
        let parameters = [
            "social_id": social_id
            ] as [String : Any]
        
        let headers = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let access_token = json["access_token"].string {
                    print("user token \(access_token)")
                    helperLogin.saveAPIToken(token: access_token)
                    completion(nil, true,false)
                }else {
                    let success = json["success"].bool
                    print(success ?? "no")
                    completion(nil,true,success)
                }
                
            }
        }
        
    }
    
    class func SignUp(fullName:String,phone:String,city_id: String,state_id: String,password: String, email:String, completion: @escaping (_ error: Error?, _ success: Bool, _ status: Bool?,_ phoneError: String?,_ emailError: String?)->Void) {
        
        let url = URLs.Signup
        print(url)
        let parameters = [
            "full_name": fullName,
            "email": email,
            "phone": phone,
            "city_id": city_id,
            "state_id": state_id,
            "password": password,
            "password_confirmation": password,
            "lat": "0.0",
            "lng": "0.0"
            ] as [String : Any]
        
        let headers = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil,nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let access_token = json["access_token"].string {
                    print("user token \(access_token)")
                    helperLogin.saveAPIToken(token: access_token)
                    completion(nil, true,false,nil,nil)
                }else {
                    let success = json["success"].bool
                    print(success ?? "no")
                    if success == false{
                        if let emailError = json["data"]["email"][0].string {
                            completion(nil,true,success,nil,emailError)
                        }
                        
                        if let phoneError = json["data"]["phone"][0].string {
                            completion(nil,true,success,phoneError,nil)
                        }
                    }else {
                        completion(nil,true,success,nil,nil)
                    }
                }
                
            }
        }
        
    }
    
}
