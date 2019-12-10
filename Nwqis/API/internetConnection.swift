//
//  internetConnection.swift
//  Nwqis
//
//  Created by Farido on 12/10/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? true
    }
}
