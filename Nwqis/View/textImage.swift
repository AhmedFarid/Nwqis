//
//  textImage.swift
//  Nwqis
//
//  Created by Farido on 11/20/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

import UIKit

class textimage: UIImage {

}

extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(2)
        self.layer.cornerRadius = self.layer.bounds.height/2
    }
}