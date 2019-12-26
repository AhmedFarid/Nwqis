//
//  API+Notifactions.swift
//  Nwqis
//
//  Created by Farido on 12/25/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Notifactions: NSObject {
    
    class func sendKayFireBase(firebaseToken: String ,completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?, _ status: Bool?)->Void) {
        
        let url = URLs.updateFirebaseToken
        
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,false, nil,false)
            return
        }
        
        print(url)
        let parameters = [
            "firebaseToken": firebaseToken,
            "deviceType": "ios"
        ]
        
        let headers = [
            "X-localization": "en",
            "Authorization": "Bearer \(user_token)"
        ]
        
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false, nil,false)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print("sssssx\(value)")
                if let status = json["status"].bool {
                    print(status)
                    if status == true{
                        if let data = json["data"].string {
                            print(data)
                            completion(nil, true, data,status)
                        }
                    }else {
                        let data = json["error"].string
                        print(data ?? "no")
                        completion(nil, true, data,status)
                    }
                }
                
            }
        }
        
    }
    
    class func countNewMessage(url: String,completion: @escaping (_ error: Error?, _ success: Bool, _ data: Int?, _ status: Bool?)->Void) {
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,false, nil,false)
            return
        }
        print(url)
        let headers = [
            "X-localization": "en",
            "Authorization": "Bearer \(user_token)"
        ]
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false, nil,false)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print("sssssx\(value)")
                if let status = json["success"].bool {
                    print(status)
                    if status == true{
                        if let data = json["data"].int {
                            print(data)
                            completion(nil, true, data,status)
                        }
                    }else {
                        let data = json["error"].int
                        print(data ?? "no")
                        completion(nil, true, data,status)
                    }
                }
                
            }
        }
        
    }
    
}
