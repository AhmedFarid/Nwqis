//
//  stutusCell.swift
//  Nwqis
//
//  Created by Farido on 1/5/20.
//  Copyright © 2020 Farido. All rights reserved.
//

import UIKit

class stutusCell: UITableViewCell {

     @IBOutlet weak var name: UILabel!
          
          func configuerCell(prodect: statesModel) {
              name.text = prodect.name
          }


}
