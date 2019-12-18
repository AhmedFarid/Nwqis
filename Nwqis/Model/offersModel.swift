//
//  offersModel.swift
//  Nwqis
//
//  Created by Farido on 12/16/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON

class offersModel: NSObject {
    
    var shop_image: String
    var image: String
    var new_price: String
    var old_price: String
    var descriptin: String
    var id: Int
    var title: String
    
    init?(dict: [String: JSON]){
        
        guard let shop_image = dict["shop_image"]?.string,let image = dict["image"]?.string, let new_price = dict["new_price"]?.string, let old_price = dict["old_price"]?.string, let descriptin = dict["description"]?.string, let id = dict["id"]?.int, let title = dict["title"]?.string else {return nil}
        
        self.shop_image = shop_image
        self.image = image
        self.new_price = new_price
        self.old_price = old_price
        self.descriptin = descriptin
        self.id = id
        self.title = title
        
    }
    
}

class myRequestsDitels: NSObject {
    var id: Int
    var email: String
    var phone: String
    var image: String
    var lat: String
    var lng: String
    
    init?(dict: [String: JSON]){
        guard let id = dict["id"]?.int,let email = dict["email"]?.string,let phone = dict["phone"]?.string,let image = dict["image"]?.string,let lat = dict["lat"]?.string,let lng = dict["lng"]?.string else {return nil}
        self.id = id
        self.email = email
        self.phone = phone
        self.image = image
        self.lat = lat
        self.lng = lng
    }
}

class myRequests: NSObject {
    var descriptin: String
    var image: String
    init?(dict: [String: JSON]){
        guard let descriptin = dict["description"]?.string,let image = dict["image"]?.string else {return nil}
        self.descriptin = descriptin
        self.image = image
    }
}


