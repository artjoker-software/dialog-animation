//
//  Staff.swift
//  StaffAnimation
//
//  Created by dev on 25.01.17.
//  Copyright © 2017 ua.artjoker. All rights reserved.
//

import UIKit

protocol StaffProtocol{
    
    var name: String { get set }
    var color: UIColor { get set }
    var imageId: String { get set }
}

class Staff: StaffProtocol {
    
    var name: String
    var color: UIColor
    var imageId: String
    
    init(name: String, color: UIColor, imageId: String){
        self.name = name
        self.color = color
        self.imageId = imageId
    }
}
