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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        colorView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    //MARK: - Callbacks
    
    @objc private func viewTapped(){
        
        let layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        layer.frame = colorView.layer.frame
        layer.position = colorView.center
        //layer.position = CGPoint(x: 0.5, y: 0.5)
        //layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
        colorView.layer.addSublayer(layer)
    }
}
