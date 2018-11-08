//
//  DetachAndFallController.swift
//  AnimationsTask
//
//  Created by vitali on 11/7/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let scales = [1.7, 1.5, 1.3]
    static let durations = [0.1, 0.1, 0.1]
}

class ScaleController: UIViewController {
    
    
    //MARK: - Views
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    
    @IBAction func startAnimation(_ sender: UIButton) {
        var currentDelay: Double = 0
        for i in 0..<Const.scales.count {
            UIView.animate(withDuration: Const.durations[i],
                           delay: currentDelay,
                           options: .curveEaseIn,
                           animations: {
                self.label.transform = CGAffineTransform(scaleX: CGFloat(Const.scales[i]),
                                                         y: CGFloat(Const.scales[i]))
                            
                self.button.transform = CGAffineTransform(scaleX: CGFloat(Const.scales[i]),
                                                          y: CGFloat(Const.scales[i]))
                            
            }, completion: nil)
            
            currentDelay += Const.durations[i]
            
            UIView.animate(withDuration: Const.durations[i],
                           delay: currentDelay,
                           options: .curveEaseIn,
                           animations: {
                self.label.transform = CGAffineTransform(scaleX: CGFloat(1),
                                                                     y: CGFloat(1))
                self.button.transform = CGAffineTransform(scaleX: CGFloat(1),
                                                                     y: CGFloat(1))
                            
            }, completion: nil)
            currentDelay += Const.durations[i]
        }
    }
    


}
