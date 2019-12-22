//
//  myRequDItelsCell.swift
//  Nwqis
//
//  Created by Farido on 12/18/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class myRequDItelsCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addrees: UILabel!
    @IBOutlet weak var images: UIImageView!
    
    var call: (()->())?
    var message: (()->())?
    
    func configuerCell(prodect: myRequestsDitels) {
        name.text = prodect.name
        images.image = UIImage(named: "3")
        self.images.layer.cornerRadius = 10.0
        images.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        let s = prodect.image
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        images.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            images.kf.setImage(with: url)
        }
        
    }
    
    @IBAction func callBTN(_ sender: Any) {
        call?()
    }
    
    @IBAction func messageBTN(_ sender: Any) {
        message?()
    }
}

