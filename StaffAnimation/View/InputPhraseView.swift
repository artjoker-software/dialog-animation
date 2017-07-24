//
//  InputPhraseView.swift
//  StaffAnimation
//
//  Created by Vadym on 247//17.
//  Copyright © 2017 Artjoker. All rights reserved.
//

import UIKit

class InputPhraseView: UIView{
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var inputTextView: RoundedTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        characterImage.layer.cornerRadius = characterImage.frame.width / 2
        characterImage.clipsToBounds = true
    }
    
    func animate(staff: StaffProtocol){
        characterImage.image = nil
        
        inputTextView.tintColor = staff.color
        inputTextView.color = staff.color
        inputTextView.text = ""
        
        inputTextView.becomeFirstResponder()
        
        if let image = UIImage(named: staff.imageId){
            characterImage.image = image
            
            animateImage()
        }
    }
    
    private func animateImage(){
        characterImage.alpha = 0.0
        
        UIView.animate(withDuration: 0.1, delay: 0.4, options: .curveEaseInOut, animations: { [weak self] in
            self?.characterImage.alpha = 1.0
            }, completion: nil)
    }
}
