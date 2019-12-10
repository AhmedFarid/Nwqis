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
    
}
