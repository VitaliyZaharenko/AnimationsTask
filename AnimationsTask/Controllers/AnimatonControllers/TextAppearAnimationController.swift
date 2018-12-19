//
//  TextAppearanceAnimationController.swift
//  AnimationsTask
//
//  Created by vitali on 11/12/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let buttonAppearText = "Animate Text Appear"
    static let buttonDisappearText = "Animate Text Disapear"
}

class TextAppearAnimationController: UIViewController {
    
    
    //MARK: - Views
    
    @IBOutlet weak var label: LabelWithTextAppearAnimation!
    @IBOutlet weak var button: UIButton!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        label.state = LabelWithTextAppearAnimation.TextState.notVisible
        setButtonText(state: label.state)
    }
    
    
    //MARK: - Actions
    @IBAction func animate(_ sender: UIButton) {
        label.animate() { state in
            self.setButtonText(state: state)
        }
    }
    
    //MARK: - Private helper methods
    
    private func setButtonText(state: LabelWithTextAppearAnimation.TextState){
        switch state {
        case .visible:
            button.setTitle(Const.buttonDisappearText, for: .normal)
        case .notVisible:
            button.setTitle(Const.buttonAppearText, for: .normal)
        }
    }
}
