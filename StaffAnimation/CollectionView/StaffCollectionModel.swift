//
//  StaffCollectionModel.swift
//  StaffAnimation
//
//  Created by Vadym on 247//17.
//  Copyright © 2017 Artjoker. All rights reserved.
//

import UIKit

enum StaffColor {
    static let six =  UIColor(red:0.584, green: 0.863, blue: 0.965, alpha: 1.000)
    static let five =  UIColor(red:0.824, green: 0.898, blue: 0.961, alpha: 1.000)
    static let four =  UIColor(red:0.988, green: 0.910, blue: 0.953, alpha: 1.000)
    static let three =  UIColor(red:0.910, green: 0.757, blue: 0.984, alpha: 1.000)
    static let two =  UIColor(red:0.973, green: 0.682, blue: 0.831, alpha: 1.000)
    static let one =  UIColor(red:0.988, green: 0.808, blue: 0.859, alpha: 1.000)
}

class StaffCollectionModel: StaffCollectionViewDataSource{

    private var allStaff: [StaffProtocol]
    
    init(){
        self.allStaff = []
        
        self.allStaff.append(Staff(name: "Fry", color: StaffColor.one, imageId: "man1"))
        self.allStaff.append(Staff(name: "Bender", color: StaffColor.two, imageId: "man2"))
        self.allStaff.append(Staff(name: "Hermes", color: StaffColor.three, imageId: "man3"))
        self.allStaff.append(Staff(name: "Leela", color: StaffColor.four, imageId: "woman1"))
        self.allStaff.append(Staff(name: "Amy", color: StaffColor.five, imageId: "woman2"))
        self.allStaff.append(Staff(name: "Elzar", color: StaffColor.six, imageId: "woman3"))
    }
    
    func numberOfItems() -> Int{
        return allStaff.count
    }
    
    func uniqueContentIdentifierForCell(at index: Int) -> String{
        return allStaff[index].imageId
    }
    
    func image(at index: Int, uniqueContentIdentifier: String, completion: @escaping ImageLoadCompletionClosure){
        guard let imageId = staff(at: index)?.imageId else { return }
        
        if let image = UIImage(named: imageId){
            completion(image, uniqueContentIdentifier)
        }
    }
    
    func staff(at index: Int) -> StaffProtocol?{
        return allStaff[index]
    }
}
