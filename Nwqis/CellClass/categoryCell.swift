//
//  categoryCell.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class categoryCell: UITableViewCell {

    var catBtnClass: (()->())?

    @IBAction func catBtn(_ sender: Any) {
        catBtnClass?()
    }
}
