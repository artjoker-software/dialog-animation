//
//  ViewController.swift
//  StaffAnimation
//
//  Created by Vadym on 247//17.
//  Copyright © 2017 Artjoker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputPhraseView: InputPhraseView!
    @IBOutlet weak var staffCollectionView: StaffCollectionView!
    @IBOutlet weak var someMiddleView: UIView!
    
    var staffSelectAnimator: StaffSelectAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        staffCollectionView.dataSource = StaffCollectionModel()
        staffCollectionView.delegate = self
        
        staffSelectAnimator = StaffSelectAnimator(viewContainer: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateConstraints(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateConstraints(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        someMiddleView.addGestureRecognizer(tap)
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }
    
    func updateConstraints(notification: Notification) {
        let userInfo = notification.userInfo!
        var keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboardEndFrame = self.view.convert(keyboardEndFrame, from: nil)
        
        UserDefaults.standard.set(Int(keyboardEndFrame.size.height), forKey: UserDefaults.Name.KeyboardHeight)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            UIView.animate(withDuration: 0.25){ [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.bottomConstraint?.constant = -strongSelf.inputPhraseView.frame.height
            }
        }
        else {
            let userInfo = notification.userInfo!
            let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIView.animate(withDuration: 0.25){ [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.bottomConstraint?.constant = keyboardEndFrame.height
            }
        }
        
        self.view.layoutIfNeeded()
    }
}

extension ViewController: StaffCollectionViewDelegate{
    
    func animateStaff(staff: StaffProtocol, imageView: UIImageView) {
        let destinationPoint = destinationPointForStaffAnimation()
        
        staffSelectAnimator.animate(imageView, destination: destinationPoint)
        
        inputPhraseView.animate(staff: staff)
    }
    
    private func destinationPointForStaffAnimation() -> CGPoint{
        let imagePosX = inputPhraseView.characterImage.frame.origin.x
        let imagePosY = inputPhraseView.characterImage.frame.origin.y
        let imageWidth = inputPhraseView.characterImage.frame.width
        let imageHeight = inputPhraseView.characterImage.frame.size.height
        let viewHeight = view.frame.size.height
        let inputPhraseHeight = inputPhraseView.frame.height
        let keyboardHeight = CGFloat(UserDefaults.standard.integer(forKey: UserDefaults.Name.KeyboardHeight))
        
        let posX = imagePosX + imageWidth / 2
        let posY = viewHeight - inputPhraseHeight + imagePosY + imageHeight / 2 - keyboardHeight
        
        return CGPoint(x: posX, y: posY)
    }
}
