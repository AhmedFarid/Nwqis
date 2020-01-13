//
//  costomTV.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

@IBDesignable
class costomTV: UITextView {
    
    
//    @IBInspectable var borderColor: UIColor = UIColor.clear{
//        didSet{
//            self.layer.borderColor = borderColor.cgColor
//            self.layer.maskedCorners =
//        }
//    }
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.layer.bounds.height/2
        }
    }
    
    @IBInspectable var cornerRadiuscoustom: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadiuscoustom
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var maskedCornerslayerMaxXMinYCorner: Bool = false{
        didSet{
            self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            self.layer.borderColor = #colorLiteral(red: 0.3058823529, green: 0.4823529412, blue: 0.8509803922, alpha: 1)
        }
    }
    
    
}


