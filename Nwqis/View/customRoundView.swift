//
//  customRoundView.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit


@IBDesignable
class customRoundView: UIView {
    
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
            self.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        }
    }
    
   
}

