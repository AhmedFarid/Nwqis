//
//  categoryCell.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Kingfisher


class categoryCell: UITableViewCell {
    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catName: UILabel!
    
    
    func configuerCell(prodect: categoriesModel) {
        catName.text = prodect.name
        catImage.image = UIImage(named: "3")
        let s = prodect.image
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        catImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            catImage.kf.setImage(with: url)
        }
        
    }
}
