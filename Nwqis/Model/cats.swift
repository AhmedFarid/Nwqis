//
//  cats.swift
//  Nwqis
//
//  Created by Farido on 1/1/20.
//  Copyright © 2020 Farido. All rights reserved.
//

import Foundation

struct categours: Codable {
    let data: [categour]
}

struct categour: Codable {
    let id: Int
    let name: String
    let image: String?
    let count_subcategoires: String?
}
 
