//
//  roundedTF.swift
//  Nwqis
//
//  Created by Farido on 11/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit


@IBDesignable
class roundedTF: UITextField {
    
    
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.layer.bounds.height/2
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.clear{
        didSet{
            self.layer.shadowColor  = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0{
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset  : CGFloat = 0{
        didSet{
            self.layer.shadowOffset  = CGSize.zero
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0{
        didSet{
            self.layer.shadowRadius  = shadowRadius
        }
    }
    
    
}
