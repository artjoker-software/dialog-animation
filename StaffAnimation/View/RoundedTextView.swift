//
//  RoundedTextView.swift
//  StaffAnimation
//
//  Created by Ekaterina Pavlyukova on 01.03.17.
//  Copyright © 2017 ua.artjoker. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedTextView: UITextView {
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
		self.layer.borderColor = color.cgColor
		self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.textContainerInset = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
       
    }
    
    @IBInspectable var radius: CGFloat = 15.0 {
        didSet { layoutSubviews() }
    }
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
			self.tintColor = color
			layoutSubviews()
        }
    }
    
}
