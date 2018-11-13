//
//  SnapAnimationController.swift
//  AnimationsTask
//
//  Created by vitali on 11/12/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit


class SnapAnimationController: UIViewController {
    
    //MARK: - Views
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Properties
    
    private var dynamicAnimator: UIDynamicAnimator!
    private var snapBehavior: UISnapBehavior?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        let collisionBehavior = UICollisionBehavior(items: [textView])
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    
    
    //MARK: - Actions
    @IBAction func tapOccured(_ sender: UITapGestureRecognizer) {
        let position = sender.location(in: view)
        snap(view: textView, to: position)
    }
    
    private func snap(view: UIView, to point: CGPoint){
        if let snapBehavior = snapBehavior {
            dynamicAnimator.removeBehavior(snapBehavior)
            self.snapBehavior = nil
        }
        
        snapBehavior = UISnapBehavior(item: view, snapTo: point)
        dynamicAnimator.addBehavior(snapBehavior!)
    }
}
