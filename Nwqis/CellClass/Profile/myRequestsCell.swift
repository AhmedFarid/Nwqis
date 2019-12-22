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
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var nembuerOfAccepted: UILabel!
    
    func configuerCell(prodect: myRequests) {
        dec.text = "Request to: \(prodect.category_name) \(prodect.subcategory_name)"
        date.text = prodect.created_at
        nembuerOfAccepted.text = "Accebted by: \(prodect.accepted_by_shop) "
        
        
    }
    
}
