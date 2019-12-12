//
//  API+CityAndAreas.swift
//  Nwqis
//
//  Created by Farido on 12/11/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_CityAndAreas: NSObject {
    
    class func getAllCity(completion: @escaping (_ error: Error?,_ citys: [citysModel]?)-> Void) {
        
        let url = URLs.cities
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let headers = [
            "X-localization": lang
        ]
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [citysModel]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = citysModel.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func getAllStates(city_id: Int,completion: @escaping (_ error: Error?,_ states: [statesModel]?)-> Void) {
        
        let url = URLs.states
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        
        let parameters = [
            "city_id": city_id
        ]
        
        let headers = [
            "X-localization": lang
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [statesModel]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = statesModel.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }

}
