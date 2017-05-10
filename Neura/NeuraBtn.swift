//
//  NeuraBtn.swift
//  NauraSample
//
//  Created by Rivi Elfenboim on 10/05/2017.
//  Copyright © 2017 Rivi Elfenboim. All rights reserved.
//

import Foundation
import UIKit

class NeuraBtn: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(rgb: 0x483D8B)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        
    }
    
}
