//
//  CityCell.swift
//  Nwqis
//
//  Created by Farido on 1/5/20.
//  Copyright © 2020 Farido. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
       
       func configuerCell(prodect: citysModel) {
           name.text = prodect.name
       }

}
