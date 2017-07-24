//
//  StaffCollectionView.swift
//  StaffAnimation
//
//  Created by Vadym on 163//17.
//  Copyright © 2017 ua.artjoker. All rights reserved.
//

import Foundation
import UIKit

class StaffCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var cellBorderView: UIView!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var cellView: UIView!
    
    var uniqueContentIdentifier: String?
    
    var borderColor: UIColor?{
        didSet{
            cellBorderView.backgroundColor = borderColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        cellView = loadNibNamed(for: StaffCollectionViewCell.self)

        initUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellView = loadNibNamed(for: StaffCollectionViewCell.self)

        initUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        uniqueContentIdentifier = nil
        
        cellImageView.image = nil
        
        if let borderColor = borderColor{
            cellBorderView.backgroundColor = borderColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            self?.cellImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }){ [weak self] success in
            self?.cellImageView.transform = CGAffineTransform.identity
        }
    }
    
    private func initUI(){
        cellBorderView.layer.cornerRadius = cellBorderView.frame.width / 2
        cellBackgroundView.layer.cornerRadius = cellBackgroundView.frame.width / 2
        
        cellImageView.makeCircle()
    }
}

