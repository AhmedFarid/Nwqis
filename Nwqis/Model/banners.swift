//
//  banners.swift
//  Nwqis
//
//  Created by Farido on 12/12/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON

class banners: NSObject {
    var image: String
    var id: Int
    
    init?(dict: [String: JSON]){
        
        guard let image = dict["image"]?.string, let id = dict["id"]?.int else {return nil}
        self.image = image
        self.id = id
        
    }
    
    
}

class news: NSObject {
    var title: String
    
    init?(dict: [String: JSON]){
        
        guard let title = dict["title"]?.string else {return nil}
        self.title = title
        
    }
    
    
}
