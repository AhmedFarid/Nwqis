//
//  categoursSubcategoursModel.swift
//  Nwqis
//
//  Created by Farido on 12/11/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON


class categoriesModel: NSObject {
    var image: String
    var name: String
    var id: Int
    var count_subcategoires: Int
    
    init?(dict: [String: JSON]){
        
        guard let image = dict["image"]?.string,let name = dict["name"]?.string, let id = dict["id"]?.int, let count_subcategoires = dict["count_subcategoires"]?.int else {return nil}
        self.image = image
        self.name = name
        self.id = id
        self.count_subcategoires = count_subcategoires
        
    }
    
}



class SubcategoriesModel: NSObject {
    var image: String
    var name: String
    var category_id: String
    var id: Int
    
    init?(dict: [String: JSON]){
        
        guard let category_id = dict["category_id"]?.string,let image = dict["image"]?.string,let name = dict["name"]?.string, let id = dict["id"]?.int else {return nil}
        self.image = image
        self.name = name
        self.id = id
        self.category_id = category_id
        
    }
    
}

