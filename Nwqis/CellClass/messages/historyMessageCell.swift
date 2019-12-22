//
//  historyMessageCell.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class historyMessageCell: UITableViewCell {

    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var lastMesagge: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var Profileimage: UIImageView!
    
    
    func configuerCell(prodect: myMessageInbox) {
        senderName.text = "message: \(prodect.name)"
        lastMesagge.text = prodect.message
        date.text = prodect.created_at
        
        Profileimage.image = UIImage(named: "3")
        self.Profileimage.layer.cornerRadius = Profileimage.bounds.height/2
        Profileimage.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        let s = prodect.image
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        Profileimage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            Profileimage.kf.setImage(with: url)
        }
    }
    
    

}
