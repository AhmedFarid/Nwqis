//
//  messageModel.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON


class messageModel: NSObject {

    
    
}

class myMessageInbox: NSObject {
    var id: Int
    var message: String
    var name: String
    var created_at: String
    var image: String
    var owner: String
    var phone: String
    var address: String
    
    init?(dict: [String: JSON]){
        guard let message = dict["message"]?.string,let owner = dict["owner"]?.string,let id = dict["shop"]?["id"].int,let name = dict["shop"]?["name"].string,let created_at = dict["created_at"]?.string,let image = dict["shop"]?["image"].string,let phone = dict["shop"]?["phone"].string,let address = dict["shop"]?["address"].string else {return nil}
        
        self.message = message
        self.id = id
        self.created_at = created_at
        self.name = name
        self.image = image
        self.owner = owner
        self.address = address
        self.phone = phone
    }

}

class myMessageDiteals: NSObject {
    
    var id: Int
    var message: String
    var name: String
    var created_at: String
    var image: String
    var setendImag: String
    
    
           
    
    init?(dict: [String: JSON]){
        if let name = dict["shop"]?["name"].string {
            self.name = name
        }else {
            self.name = ""
        }
        
        guard let message = dict["message"]?.string,let id = dict["id"]?.int,let created_at = dict["created_at"]?.string,let setendImag = dict["image"]?.string,let image = dict["shop"]?["image"].string else {return nil}
        
        self.message = message
        self.id = id
        self.created_at = created_at
        self.image = image
        self.setendImag = setendImag
    }
    
    
}
