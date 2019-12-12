//
//  CollectionViewCell.swift
//  Nwqis
//
//  Created by Farido on 12/12/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    func configuerCell(prodect: banners) {
        image.image = UIImage(named: "3")
        let s = prodect.image
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        image.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            image.kf.setImage(with: url)
        }
        
    }
}
