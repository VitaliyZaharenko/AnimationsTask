//
//  ViewAppearDisappearAnimationController.swift
//  AnimationsTask
//
//  Created by vitali on 11/13/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit


class ViewAppearDisappearAnimationController: UIViewController {

    
    //MARK: - Views
    @IBOutlet weak var colorView: ColorView!
    
    //MARK: - Properties
    
    private var tapGestureRecognizer: UIGestureRecognizer!
    private var layer: CALayer!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        colorView.addGestureRecognizer(tapGestureRecognizer)
        
        layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        let minDimen = layer.frame.size.width > layer.frame.size.height ? layer.frame.size.height : layer.frame.size.width
        
        layer.cornerRadius = 30
        layer.frame = colorView.bounds
        layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
        colorView.layer.addSublayer(layer)
        
    }
    
    //MARK: - Callbacks
    
    @objc private func viewTapped(){
        
        
    }
    
    private func animateViaBasicAnimation(){
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.fromValue = layer.transform
        animation.toValue = CATransform3DTranslate(layer.transform, 0, 300, 0)
        
    }
    
}
