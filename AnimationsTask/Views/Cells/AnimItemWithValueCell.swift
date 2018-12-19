//
//  AnimItemWithValueCell.swift
//  AnimationsTask
//
//  Created by zaharenkov on 08/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let keyboardCancelTitle = "Cancel"
    static let keyboardDoneTitle = "Done"
    static let defaultAngle = 180
}

class AnimItemWithValueCell: UITableViewCell {
    
    //MARK: - Views
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var angleTextField: UITextField!
    
    private var doneKeyboardBarButton: UIBarButtonItem!
    
    
    //MARK: - Properties
    
    weak var delegate: GravityAnimationDelegate?
    
    var angleDeg: Int {
        set {
            angleTextField.text = String(newValue)
            setDoneEnable(text: angleTextField.text)
        }
        get {
            if let text = angleTextField.text, let angle = Int(text){
                return angle
            } else {
                return Const.defaultAngle
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        angleTextField.delegate = self
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        let cancel = UIBarButtonItem(title: Const.keyboardCancelTitle, style: .plain, target: self, action: #selector(cancelClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        doneKeyboardBarButton = UIBarButtonItem(title: Const.keyboardDoneTitle, style: .plain, target: self, action: #selector(doneClicked))
        setDoneEnable(text: angleTextField.text)
        toolbar.items = [
            cancel, space, doneKeyboardBarButton
        ]
        toolbar.sizeToFit()
        angleTextField.inputAccessoryView = toolbar
        
    }
    
    //MARK: - Callbacks
    
    @objc func cancelClicked(){
        angleTextField.resignFirstResponder()
    }
    
    @objc func doneClicked(){
        if let text = angleTextField.text, let angle = Int(text) {
            delegate?.setAngle(degrees: angle)
            angleTextField.resignFirstResponder()
        }
    }
    
    //MARK: - Helper private methods
    
    private func setDoneEnable(text: String?){
        doneKeyboardBarButton.isEnabled = !(text ?? "").isEmpty
    }
    
}

//MARK: - UITextFieldDelegate

extension AnimItemWithValueCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let updated = currentText.replacingCharacters(in: range, with: string)
        setDoneEnable(text: updated)
        return true
        
    }
    
}
