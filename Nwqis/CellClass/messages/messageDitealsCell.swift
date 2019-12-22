//
//  messageDitealsCell.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class messageDitealsCell: UITableViewCell {

    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageDate: UIImageView!
    
    func configuerCell(prodect: myMessageDiteals) {
        date.text = prodect.created_at
        message.text = prodect.message
        profileName.text = prodect.name
        profileImage.image = UIImage(named: "3")
        let s = prodect.image
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        profileImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            profileImage.kf.setImage(with: url)
        }
        
        let x = prodect.setendImag
        let encodedLinkx = x.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURLx = NSURL(string: encodedLinkx!)! as URL
        messageDate.kf.indicatorType = .activity
        if let urlx = URL(string: "\(encodedURLx)") {
            messageDate.kf.setImage(with: urlx)
        }
        
        
    }
    
}
