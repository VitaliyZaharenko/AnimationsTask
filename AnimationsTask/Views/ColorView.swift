//
//  ColorView.swift
//  AnimationsTask
//
//  Created by vitali on 11/13/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

@IBDesignable
class ColorView: UIView {
    
    
    //MARK: - Properties
    
    @IBInspectable var borderWidth: Int = 5 {
        didSet {
            updateMainLayer()
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            updateMainLayer()
        }
    }
    
    private var _cornerRadius: Int = 5
    
    @IBInspectable var cornerRadius: Int {
        get {
            return _cornerRadius
        }
        set {
            _cornerRadius = clampedCornerRadius(radiusToClamp: newValue)
            updateMainLayer()
        }
    }
    
    @IBInspectable var animationDuration: Double = 1.0
    @IBInspectable var faded: Bool = false {
        didSet {
            self.isHidden = faded
        }
    }
    
    //MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit(){
        updateMainLayer()
        self.isHidden = faded
    }
    
    //MARK: - Private helper methods
    
    private func updateMainLayer(){
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    private func clampedCornerRadius(radiusToClamp radius: Int) -> Int {
        let maxRadius = maxCornerRadius()
        if radius < 0 {
            return 0
        }
        if radius > maxRadius {
            return maxRadius
        } else {
            return radius
        }
    }
    
    private func maxCornerRadius() -> Int {
        let minDimensionSize = self.frame.size.width > self.frame.size.height ? self.frame.size.height : self.frame.size.width
        return Int(minDimensionSize / 2)
    }

}
