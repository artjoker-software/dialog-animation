//
//  StaffCollectionView.swift
//  StaffAnimation
//
//  Created by Vadym on 163//17.
//  Copyright © 2017 ua.artjoker. All rights reserved.
//

import Foundation
import UIKit

typealias ImageLoadCompletionClosure = (_ image: UIImage, _ uniqueContentIdentifier: String) -> Void

protocol StaffCollectionViewDataSource {
    
    func numberOfItems() -> Int
    func uniqueContentIdentifierForCell(at index: Int) -> String
    func image(at index: Int, uniqueContentIdentifier: String, completion: @escaping ImageLoadCompletionClosure)
    func staff(at index: Int) -> StaffProtocol?
    
}

protocol StaffCollectionViewDelegate{
    
    func animateStaff(staff: StaffProtocol, imageView: UIImageView)
}

class StaffCollectionView: UIView{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: StaffCollectionViewDataSource?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var delegate: StaffCollectionViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibNamed(for: StaffCollectionView.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNibNamed(for: StaffCollectionView.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateCollectionViewLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.allowsSelection = true
        
        collectionView.register(StaffCollectionViewCell.self, forCellWithReuseIdentifier: StaffCollectionViewCell.reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCollectionViewLayout()
    }
    
    private func updateCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 76, height: self.frame.height)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = layout
    }
}

//MARK: - UICollectionViewDataSource

extension StaffCollectionView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let input = dataSource{
            return input.numberOfItems()
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaffCollectionViewCell.reuseIdentifier, for: indexPath)
        
        guard let input = dataSource else { return cell }
        
        if let cell = cell as? StaffCollectionViewCell{
            let uniqueContentId = input.uniqueContentIdentifierForCell(at: indexPath.row)
            
            cell.uniqueContentIdentifier = uniqueContentId
            
            input.image(at: indexPath.row, uniqueContentIdentifier: uniqueContentId){ (image, uniqueContentIdentifier) in
                if cell.uniqueContentIdentifier == uniqueContentIdentifier{
                    cell.cellImageView.image = image
                }
            }
            
            guard let staff = input.staff(at: indexPath.row) else {
                cell.titleLabel.text = ""
                cell.borderColor = UIColor.white
                
                return cell
            }
            
            cell.titleLabel.text = staff.name
            cell.borderColor = staff.color
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension StaffCollectionView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? StaffCollectionViewCell else { return }
        guard let characterImage = cell.cellImageView.image?.copy() as? UIImage else { return }
        guard let staff = dataSource?.staff(at: indexPath.row) else { return }
        
        let imageView = UIImageView(image: characterImage)
        imageView.frame = cell.convert(cell.cellImageView.frame, to: nil)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        
        delegate.animateStaff(staff: staff, imageView: imageView)
    }
}
