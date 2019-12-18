//
//  myRequestsCell.swift
//  Nwqis
//
//  Created by Farido on 12/18/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class myRequestsCell: UITableViewCell {
    
    @IBOutlet weak var dec: UILabel!
    
    func configuerCell(prodect: myRequests) {
        dec.text = prodect.descriptin
    }
    
}
