//
//  RotationAnimationController.swift
//  AnimationsTask
//
//  Created by zaharenkov on 08/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let stageDuration = 0.3
    static let numberOfStages = 3
    static let fallDuration = 0.3
}

class UnhookAnimationController: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    //MARK: - Constraints
    
    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func startAnimation(_ sender: UIButton) {
        
        animate(view: label)
        animate(view: button)
        
    }
    
    private func animate(view: UIView){
        
        var currentDelay: Double = 0
        
        let maxAngle = Double.pi
        let stopAngle = Double.pi / 1.9
        let angleDelta = (maxAngle - stopAngle) / Double(Const.numberOfStages)
        
        if view.layer.anchorPoint.x == 0.5 && view.layer.anchorPoint.y == 0.5 {
            let frame = view.frame
            view.layer.anchorPoint = CGPoint(x: 0, y: 0)
            view.frame = frame
            
        }
        
        for i in stride(from: Const.numberOfStages - 1, through: 0, by: -1) {

            let leftAngle = stopAngle + (angleDelta * Double(i))
            let rightAngle = stopAngle - (angleDelta * Double(i))

            UIView.animate(withDuration: Const.stageDuration,
                           delay: currentDelay,
                           options: .curveEaseOut,
                           animations: {
                            view.transform = CGAffineTransform(rotationAngle: CGFloat(leftAngle))

            }, completion: nil)

            currentDelay += Const.stageDuration

            UIView.animate(withDuration: Const.stageDuration,
                           delay: currentDelay,
                           options: .curveEaseOut,
                           animations: {
                            view.transform = CGAffineTransform(rotationAngle: CGFloat(rightAngle))

            }, completion: nil)

            currentDelay += Const.stageDuration

        }
        
        
        UIView.animate(withDuration: Const.fallDuration,
                       delay: currentDelay - Const.stageDuration,
                       options: .curveEaseIn,
                       animations: {
                        self.verticalConstraint.constant += self.view.frame.size.height / 2
                        self.view.layoutIfNeeded()
        }, completion: { (completed) in
            if completed {
                view.removeFromSuperview()
            }
        })
    }
}
