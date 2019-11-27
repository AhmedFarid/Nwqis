//
//  helper.swift
//  Nwqis
//
//  Created by Farido on 11/27/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import Foundation
import UIKit


class helperAddress: NSObject {
    
    
    class func deleteOldAddreess() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "city")
        def.removeObject(forKey: "area")
        def.removeObject(forKey: "zone")
        def.removeObject(forKey: "streetAddresss")
        def.removeObject(forKey: "lat")
        def.removeObject(forKey: "long")
        def.synchronize()
    }
    
    class func saveNewAddress(city: String,area: String,zone: String, streetAddresss: String, lat: String, long: String) {
        let def = UserDefaults.standard
        def.setValue(city, forKey: "city")
        def.setValue(area, forKey: "area")
        def.setValue(zone, forKey: "zone")
        def.setValue(streetAddresss, forKey: "streetAddresss")
        def.setValue(lat, forKey: "lat")
        def.setValue(long, forKey: "long")
        def.synchronize()
    }
    
    class func getAddresss() -> (city: String?,area: String?, zone: String?, streetAddresss: String?, lat: String?, long: String?) {
        let def = UserDefaults.standard
        return (def.object(forKey: "city") as? String,def.object(forKey: "area") as? String,def.object(forKey: "zone") as? String,def.object(forKey: "streetAddresss") as? String,def.object(forKey: "lat") as? String,def.object(forKey: "long") as? String)
    }
}
