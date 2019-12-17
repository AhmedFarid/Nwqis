//
//  offersCell.swift
//  Nwqis
//
//  Created by Farido on 12/16/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class offersCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var dec: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var offerImage: UIImageView!
    
    func configuerCell(prodect: offersModel) {
        dec.text = prodect.descriptin
        title.text = prodect.title
        logo.image = UIImage(named: "3")
        let s = prodect.shop_image
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        logo.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            logo.kf.setImage(with: url)
        }
        
        let x = prodect.image
        let encodedLinkx = x.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURLx = NSURL(string: encodedLinkx!)! as URL
        offerImage.kf.indicatorType = .activity
        if let urlx = URL(string: "\(encodedURLx)") {
            offerImage.kf.setImage(with: urlx)
        }
        
        
    }
}
