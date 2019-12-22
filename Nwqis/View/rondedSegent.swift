//
//  rondedSegent.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class rondedSegent: UISegmentedControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = layer.bounds.height / 2
        
        
        
        
    }
}
