//
//  offersModel.swift
//  Nwqis
//
//  Created by Farido on 12/16/19.
//  Copyright © 2019 Farido. All rights reserved.
//
//
//"description" : "offers",
// "shop_image" : "https:\/\/nwqis.com\/uploads\/shops\/1577803551.jpg",
// "old_price" : null,
// "title" : "offers",
// "id" : 4,
// "image" : "https:\/\/nwqis.com\/uploads\/offers\/1577976130.png",
// "new_price" : null

import UIKit
import SwiftyJSON

class offersModel: NSObject {
    
    var shop_image: String
    var image: String
    //var new_price: String
    //var old_price: String
    var descriptin: String
    var id: Int
    var title: String
    
    init?(dict: [String: JSON]){
        
        guard let shop_image = dict["shop_image"]?.string,let image = dict["image"]?.string, let descriptin = dict["description"]?.string, let id = dict["id"]?.int, let title = dict["title"]?.string else {return nil}
        
        self.shop_image = shop_image
        self.image = image
        //self.new_price = new_price
        //self.old_price = old_price
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
    var name: String
    var premium: String
    var address: String
    
    init?(dict: [String: JSON]){
        guard let id = dict["id"]?.int,let email = dict["email"]?.string,let phone = dict["phone"]?.string,let image = dict["image"]?.string,let lat = dict["lat"]?.string,let lng = dict["lng"]?.string,let name = dict["name"]?.string,let premium = dict["premium"]?.string,let address = dict["address"]?.string else {return nil}
        self.id = id
        self.email = email
        self.phone = phone
        self.image = image
        self.lat = lat
        self.lng = lng
        self.name = name
        self.premium = premium
        self.address = address
    }
}

class myRequests: NSObject {
    var descriptin: String
    var image: String
    var category_name: String
    var subcategory_name: String
    var city_name: String
    var state_name: String
    var created_at: String
    var id: Int
    var accepted_by_shop: Int
    
    init?(dict: [String: JSON]){
        guard let descriptin = dict["description"]?.string,let id = dict["id"]?.int,let image = dict["image"]?.string,let category_name = dict["category_name"]?.string,let subcategory_name = dict["subcategory_name"]?.string,let city_name = dict["city_name"]?.string,let state_name = dict["state_name"]?.string,let created_at = dict["created_at"]?.string,let accepted_by_shop = dict["accepted_by_shop"]?.int else {return nil}
        self.descriptin = descriptin
        self.image = image
        self.category_name = category_name
        self.subcategory_name = subcategory_name
        self.city_name = city_name
        self.state_name = state_name
        self.created_at = created_at
        self.id = id
        self.accepted_by_shop = accepted_by_shop
    }
}


