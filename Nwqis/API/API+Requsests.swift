//
//  API+Requsests.swift
//  Nwqis
//
//  Created by Farido on 12/12/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API_Requsests: NSObject {
    
    
    class func getCatBanner(category_id: String,completion: @escaping (_ error: Error?,_ categours: [banners]?,_ success: Bool?)-> Void) {
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil,nil,false)
            return
        }
        
        let url = URLs.banners
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
                    var products = [banners]()
                    for data in dataArray {
                        if let data = data.dictionary, let prodect = banners.init(dict: data){
                            products.append(prodect)
                        }
                    }
                    completion(nil, products,success)
                }
            }
        }
    }
    
    
    
}
