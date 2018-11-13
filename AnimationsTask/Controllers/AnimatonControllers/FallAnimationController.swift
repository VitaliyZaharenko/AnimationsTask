//
//  FallAnimationController.swift
//  AnimationsTask
//
//  Created by vitali on 11/7/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let buttonAnimationDuration = 1.0
    static let labelAnimationDuration = 0.2
}

class FallAnimationController: UIViewController {
    
    //MARK: - Views
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    //MARK: - Constraints
    @IBOutlet weak var buttonVerticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    
    @IBAction func startAnimation(_ sender: UIButton) {
        
        let buttonVerticalConstant = (view.frame.size.height / 2) - (button.frame.size.height / 2)
        UIView.animate(withDuration: Const.buttonAnimationDuration, delay: 0, options: .curveEaseIn, animations: {
            self.buttonVerticalCenterConstraint.constant = buttonVerticalConstant
            self.button.setTitleColor(UIColor.red, for: .normal)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: Const.labelAnimationDuration,
                       delay: Const.buttonAnimationDuration, options: .curveLinear, animations: {
            self.labelBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}

//MARK: - Private Helper Methods

private extension FallAnimationController {
    
}

