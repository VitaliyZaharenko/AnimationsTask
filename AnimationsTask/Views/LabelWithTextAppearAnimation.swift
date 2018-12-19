//
//  LabelWithTextAppearAnimation.swift
//  AnimationsTask
//
//  Created by zaharenkov on 13/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

fileprivate struct Const {
    static let characterDelayOverallDurationThreshold = 0.5
}


class LabelWithTextAppearAnimation: UILabel {
    
    enum TextState {
        case visible
        case notVisible
    }

    
    //MARK: - Properties
    
    private var displayLink: CADisplayLink!
    private let animationDuration = 2.0
    private var characterDelays = [CFTimeInterval]()
    private var isAnimated = false
    
    private var startTime: CFTimeInterval = 0
    private var endTime: CFTimeInterval = 0
    
    private var currentState: TextState = .visible
    
    var state: TextState {
        get {
            return currentState
        }
        set {
            currentState = newValue
            setupAttributedText()
        }
    }
    
    private var completionClosure: ((TextState) -> Void)?
    
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
        displayLink = CADisplayLink(target: self, selector: #selector(animateTextStep))
        displayLink.isPaused = true
        displayLink.add(to: RunLoop.current, forMode: .commonModes)
        setupAttributedText()
        setupCharacterDelays()
    }
    
    private func setupAttributedText(){
        guard let text = self.text, let labelColor = self.textColor else { return }
        let color: UIColor = {
            switch currentState {
            case .notVisible:
                return labelColor.withAlphaComponent(0.0)
            case .visible:
                return labelColor.withAlphaComponent(0.1)
            }
        }()
        self.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor: color])
    }
    
    private func setupCharacterDelays(){
        guard let attributedString = self.attributedText else {
            return
        }
        characterDelays = [CFTimeInterval]()
        for _ in 0..<attributedString.length {
            let overallDurationThreshold = Const.characterDelayOverallDurationThreshold
            let randomOverallDurationDelay = Double.randomZeroOne() * overallDurationThreshold
            let randomDuration = animationDuration * randomOverallDurationDelay
            characterDelays.append(randomDuration)
        }
        
    }
    
    
    func animate(completion: ((TextState) -> Void)? = nil){
        if isAnimated {
            return
        }
            
        startTime = CACurrentMediaTime()
        endTime = startTime + animationDuration
        self.completionClosure = completion
        self.displayLink.isPaused = false
        isAnimated = true
    }
    
    
    //MARK: - Callbacks
    
    @objc func animateTextStep(){
        let now = CACurrentMediaTime()
        if(now > endTime){
            switch currentState {
            case .notVisible: currentState = .visible
            case .visible: currentState = .notVisible
            }
            displayLink.isPaused = true
            isAnimated = false
            completionClosure?(currentState)
            completionClosure = nil
            setupCharacterDelays()
            return
        }
        
        guard let attributedString = self.attributedText as? NSMutableAttributedString else {
            fatalError("Nil or Immutable")
        }
        
        for i in 0..<attributedString.length {
            attributedString.enumerateAttribute(
                .foregroundColor,
                in: NSMakeRange(i, 1),
                options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired ,
                using: { value, range, _ in
                    guard let color = value as? UIColor else {
                        fatalError("Not color")
                    }
                    let delay = characterDelays[i]
                    if(now < startTime + delay){
                        return
                    }
                    let overallAnimationDuration = animationDuration - delay
                    let currentAnimationTime = now - startTime - delay
                    let fraction = currentAnimationTime / overallAnimationDuration
                    let currentAlpha: Double = {
                        switch currentState {
                        case .visible:
                            return 1.0 - fraction
                        case .notVisible:
                            return fraction
                        }
                    }()
                    attributedString.addAttributes([NSAttributedStringKey.foregroundColor: color.withAlphaComponent(CGFloat(currentAlpha))], range: range)
                    }
            )
        }
        self.text = ""
        self.attributedText = attributedString
    }
}
