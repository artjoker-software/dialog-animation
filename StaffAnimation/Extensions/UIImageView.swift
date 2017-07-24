//
//  UIImageView.swift
//  StaffAnimation
//
//  Created by Mac user on 05.03.17.
//  Copyright © 2017 ua.artjoker. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
	
	func makeCircle (){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
        
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
		guard let context = UIGraphicsGetCurrentContext() else { return }
        
		self.layer.render(in: context)
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.clipsToBounds = true
		self.image = result
	}
	
}

