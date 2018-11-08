//
//  DetachAndFallController.swift
//  AnimationsTask
//
//  Created by vitali on 11/7/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let stageDuration = 0.1
    static let numberOfStages = 4
}

class ScaleAnimationController: UIViewController {
    
    
    //MARK: - Views
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    //MARK: - Properties
    
    var scaleFactor: Float?
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(scaleFactor == nil){
            scaleFactor = 1.7
        }
    }
    
    //MARK: - Actions
    
    @IBAction func startAnimation(_ sender: UIButton) {
        
        animate(view: button)
        animate(view: label, delay: 0.1)
        
    }
    
    private func animate(view viewToAnimate: UIView, delay: Double = 0){
        var currentDelay: Double = delay
        
        guard let scaleFactor = scaleFactor else { return }
        
        let scaleDelta = abs(scaleFactor - 1) / Float(Const.numberOfStages)
        var currentScale = scaleFactor
        
        for _ in 0..<Const.numberOfStages {
            
            UIView.animate(withDuration: Const.stageDuration,
                           delay: currentDelay,
                           options: .curveEaseIn,
                           animations: {
                        viewToAnimate.transform = CGAffineTransform(scaleX: CGFloat(currentScale),
                                                                     y: CGFloat(currentScale))
                            
                            
            }, completion: nil)
            
            currentDelay += Const.stageDuration
            
            UIView.animate(withDuration: Const.stageDuration,
                           delay: currentDelay,
                           options: .curveEaseIn,
                           animations: {
                           viewToAnimate.transform = CGAffineTransform(scaleX: CGFloat(1),
                                                                     y: CGFloat(1))
            }, completion: nil)
            
            currentDelay += Const.stageDuration
            currentScale += (scaleFactor < 1.0) ? scaleDelta : -scaleDelta
            
        }
    }
}
