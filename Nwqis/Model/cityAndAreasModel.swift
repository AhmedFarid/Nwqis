//
//  cityAndAreasModel.swift
//  Nwqis
//
//  Created by Farido on 12/11/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON


class citysModel: NSObject {
    var name: String
    var id: Int
    
    init?(dict: [String: JSON]){
        
        guard let name = dict["name"]?.string, let id = dict["id"]?.int else {return nil}
        self.name = name
        self.id = id
    }
    
}

class statesModel: NSObject {
    var name: String
    var id: Int
    
    init?(dict: [String: JSON]){
        
        guard let name = dict["name"]?.string, let id = dict["id"]?.int else {return nil}
        self.name = name
        self.id = id
    }
    
}
