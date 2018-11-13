//
//  GravityAnimationController.swift
//  AnimationsTask
//
//  Created by zaharenkov on 08/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let defaultAngle = -90.rad
    static let magnitude: CGFloat = 0.05
}

class GravityAnimationController: UIViewController {
    
    //MARK: - Views
    
    @IBOutlet weak var containerView: UIStackView!
    
    //MARK: - Properties
    
    private var dynamicAnimator: UIDynamicAnimator!
    var angle: Double?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: containerView)
        if angle == nil {
            angle = Const.defaultAngle
        }
    }
    
    //MARK: - Actions
    @IBAction func startAnimation(_ sender: UIButton) {
        let gravity = UIGravityBehavior(items: [containerView])
        guard let angle = angle else { return }
        gravity.angle = CGFloat(angle)
        gravity.magnitude = Const.magnitude
        dynamicAnimator.addBehavior(gravity)
    }
    
}
