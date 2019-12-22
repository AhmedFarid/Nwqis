//
//  API+Messages.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Messages: NSObject {
    
    class func getMessageHistory(owner: String, completion: @escaping (_ error: Error?,_ categours: [myMessageInbox]?,_ success: Bool?)-> Void) {
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,nil,false)
            return
        }
        let url = URLs.customerInboxes
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        
        let parameters = [
            "owner": owner
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
                    var products = [myMessageInbox]()
                    for data in dataArray {
                        if let data = data.dictionary, let prodect = myMessageInbox.init(dict: data){
                            products.append(prodect)
                        }
                    }
                    completion(nil, products,success)
                }
            }
        }
    }
    
    class func getMessageDiteals(shop_id: Int,owner: String, completion: @escaping (_ error: Error?,_ categours: [myMessageDiteals]?,_ success: Bool?)-> Void) {
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,nil,false)
            return
        }
        let url = URLs.inboxHistory
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        
        let parameters = [
            "owner": owner,
            "shop_id": shop_id
            ] as [String : Any]
        print(parameters)
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
                    var products = [myMessageDiteals]()
                    for data in dataArray {
                        if let data = data.dictionary, let prodect = myMessageDiteals.init(dict: data){
                            products.append(prodect)
                        }
                    }
                    completion(nil, products,success)
                }
            }
        }
    }
    
    class func newMessage(image: UIImage,message: String,shop_id: String,completion: @escaping (_ error: Error?, _ success: Bool,_ successs: Bool?,_ message: String?,_ phoneError: String?,_ emailError: String?)->Void) {
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,false,false,nil,nil,nil)
            return
        }
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let url = URLs.addCustomerShopInbox+"?message=\(message.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? message)&shop_id=\(shop_id.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? shop_id)"
        print(url)
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
            if let data = image.jpegData(compressionQuality: 0.5) {
                form.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
            switch result {
            case .failure(let error):
                print(error)
                completion(error, false,false,nil,nil,nil)
                
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress(closure: { (progress: Progress) in
                    print("farido\(progress)")
                })
                upload.responseJSON(completionHandler: { (response: DataResponse<Any>) in
                    switch response.result
                    {
                    case .failure(let error):
                        print(error)
                        completion(error, false,false,nil,nil,nil)
                        
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
                })
            }
        }
    }
    
}