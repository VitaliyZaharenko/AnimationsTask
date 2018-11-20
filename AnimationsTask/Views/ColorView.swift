//
//  ColorView.swift
//  AnimationsTask
//
//  Created by vitali on 11/13/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    
    static let cornerRadiusAnimationDuration: Double = 0.25
    static let cornerRadiusAnimationDelay: Double = 0.3
    static let scaleAnimationKeyTimes: [NSNumber] = [0, 0.8, 1]
    static let scaleAnimationMaxScale: CGFloat = 1.2
    static let scaleAnimationDuration: Double = 0.5
    
    static let fadeAnimationDuration: Double = 0.5
    
    static let particlesAnimationDuration: Double = 1.0
    static let particleAnimationTranslate = 500 * 2
}

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
    
    
    public fileprivate(set) var isVisible: Bool = true
    fileprivate var isAnimatingNow: Bool = false
    
    public var visibilityObserver: ((Bool) -> Void)?
    
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
    
    func maxCornerRadius() -> Int {
        let minDimensionSize = self.frame.size.width > self.frame.size.height ? self.frame.size.height : self.frame.size.width
        return Int(minDimensionSize / 2)
    }
}

//MARK: - Animation methods

extension ColorView {

    func animateAppear(){

        if(isAnimatingNow || isVisible){
            return
        }

        isAnimatingNow = true

        let currentCornerRadius = self.cornerRadius

        class CompletionDelegate: NSObject, CAAnimationDelegate {

            weak var view: ColorView?
            let cornerRadius: Int

            init(view: ColorView, cornerRadius: Int){
                self.view = view
                self.cornerRadius = cornerRadius
            }

            func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
                view?.cornerRadius = cornerRadius
            }

        }

        self.cornerRadius = maxCornerRadius()
        let cornerRadiusAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerRadiusAnimation.fromValue = maxCornerRadius()
        cornerRadiusAnimation.toValue = currentCornerRadius
        cornerRadiusAnimation.beginTime = CACurrentMediaTime() + Const.cornerRadiusAnimationDelay
        cornerRadiusAnimation.duration = Const.cornerRadiusAnimationDuration
        cornerRadiusAnimation.delegate = CompletionDelegate(view: self, cornerRadius: currentCornerRadius)

        self.layer.add(cornerRadiusAnimation, forKey: "CornerRadius")


        class AppearCompletionDelegate: NSObject, CAAnimationDelegate {

            weak var view: ColorView?

            init(view: ColorView){
                self.view = view
            }
            
            func animationDidStart(_ anim: CAAnimation) {
                view?.layer.opacity = 1.0
            }

            func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
                view?.isAnimatingNow = false
                view?.isVisible = true
                view?.visibilityObserver?(true)
            }

        }


        let scaleAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.transform))
        let scaleTransforms: [CATransform3D] = [CATransform3DScale(self.layer.transform, 0.0, 0.0, 1),
                                                CATransform3DScale(self.layer.transform,
                                                                   Const.scaleAnimationMaxScale,
                                                                   Const.scaleAnimationMaxScale,
                                                                   1),
                                                self.layer.transform]
        scaleAnimation.values = scaleTransforms
        scaleAnimation.keyTimes = Const.scaleAnimationKeyTimes
        scaleAnimation.duration = Const.scaleAnimationDuration
        scaleAnimation.delegate = AppearCompletionDelegate(view: self)
        self.layer.add(scaleAnimation, forKey: "scale")
    }

    func animateDisappear(){

        if(isAnimatingNow || !isVisible) {
            return
        }

        isAnimatingNow = true

        class CompletionDelegate: NSObject, CAAnimationDelegate {
            weak var view: ColorView?
            init(view: ColorView){
                self.view = view
            }
            func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
                if let view = self.view {
                    view.visibilityObserver?(true)
                    view.isVisible = false
                    let color = view.layer.backgroundColor
                    view.layer.opacity = 0.0
                    ColorView.animateParticles(view: view, particleColor: UIColor.red.cgColor)
                }
            }
        }

        let fadeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.opacity))
        fadeAnimation.duration = Const.fadeAnimationDuration
        fadeAnimation.values = [1.0, 0.0]
        fadeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        fadeAnimation.delegate = CompletionDelegate(view: self)
        self.layer.add(fadeAnimation, forKey: "FadeAnimation")



    }

    private static func animateParticles(view: ColorView, particleColor: CGColor){
        class CompletionDelegate: NSObject, CAAnimationDelegate {
            weak var layer: CALayer?
            weak var view: ColorView?
            init(layer: CALayer, view: ColorView){
                self.layer = layer
                self.view = view
            }

            func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
                layer?.removeFromSuperlayer()
                view?.isAnimatingNow = false
            }
        }
        //up, right, down, left
        let xAndYKoeff = [(0, -1), (1, 0), (0, 1), (-1, 0)]
        for (xMult, yMult) in xAndYKoeff {
            let layer = CALayer()
            layer.backgroundColor = particleColor
            layer.frame = view.bounds
            layer.cornerRadius = 20
            layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
            view.layer.addSublayer(layer)

            let moveAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.transform))
            let moveTransforms = [layer.transform,
                                  CATransform3DTranslate(layer.transform,
                                                         CGFloat(xMult * Const.particleAnimationTranslate),
                                                         CGFloat(yMult * Const.particleAnimationTranslate),
                                                         0)]
            moveAnimation.values = moveTransforms
            moveAnimation.delegate = CompletionDelegate(layer: layer, view: view)
            moveAnimation.duration = Const.particlesAnimationDuration
            moveAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
            layer.add(moveAnimation, forKey: "MoveDirection: (\(xMult), \(yMult))")
        }
    }
}

