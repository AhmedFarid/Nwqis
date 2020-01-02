//
//  API+CategoursAndSubCategours.swift
//  Nwqis
//
//  Created by Farido on 12/11/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_CategoursAndSubCategours: NSObject {
    
    class func getAllCategours(search: String,Url: String,completion: @escaping (_ error: Error?,_ categours: [categoriesModel]?,_ success: Bool?,_ Search: String?)-> Void) {
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,nil,false,nil)
            return
        }
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        
        let parameters = [
            "search": search
        ]
        
        print(parameters)
        Alamofire.request(Url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil, false,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                let success = json["success"].bool
                if success == true {
                    guard let dataArray = json["data"].array else{
                        completion(nil, nil,success,nil)
                        return
                    }
                    print(dataArray)
                    var products = [categoriesModel]()
                    for data in dataArray {
                        if let data = data.dictionary, let prodect = categoriesModel.init(dict: data){
                            products.append(prodect)
                        }
                    }
                    completion(nil, products,success,nil)
                }else{
                    if let Search = json["data"]["search"][0].string {
                        completion(nil,nil,success,Search)
                    }
                }
                
            }
        }
    }
    
    class func getAllSubCategours(search: String, Url:String,category_id: Int,completion: @escaping (_ error: Error?,_ categours: [SubcategoriesModel]?,_ success: Bool?,_ data: String?)-> Void) {
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,nil,false,nil)
            return
        }
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        
        let parameters = [
            "category_id": category_id,
            "search":search
            ] as [String : Any]
        
        let headers = [
            "X-localization": lang,
            "Authorization": "Bearer \(user_token)"
        ]
        Alamofire.request(Url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil, false,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                let success = json["success"].bool
                if success == true {
                    guard let dataArray = json["data"].array else{
                        completion(nil, nil,success,nil)
                        return
                    }
                    print(dataArray)
                    var products = [SubcategoriesModel]()
                    for data in dataArray {
                        if let data = data.dictionary, let prodect = SubcategoriesModel.init(dict: data){
                            products.append(prodect)
                        }
                    }
                    completion(nil, products,success,nil)
                }
                else{
                    if let Search = json["data"]["search"][0].string {
                        completion(nil,nil,success,Search)
                    }
                }
            }
        }
    }
}
