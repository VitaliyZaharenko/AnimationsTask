//
//  AnimationItem.swift
//  AnimationsTask
//
//  Created by vitali on 11/7/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

enum AnimationItem {
    
    case fallAnimation
    case scaleAnimation(Float)
    case unhookAnimation
    case gravityAnimation(Int)
    case snapAnimation
    case textAppearAnimation
    case gradientAnimation([UIColor])
    
    var name: String {
        switch self {
        case .fallAnimation:
            return "Fall Animation"
        case .scaleAnimation(_):
            return "Scale Animation"
        case .unhookAnimation:
            return "Unhook Animation"
        case .gravityAnimation:
            return "Gravity Animation"
        case .snapAnimation:
            return "Snap Animation"
        case .textAppearAnimation:
            return "Text Appear Animation"
        case .gradientAnimation(_):
            return "Gradient Animation"
        }
    }
    
    static var all: [AnimationItem] {
        return [.fallAnimation,
                .scaleAnimation(2),
                .unhookAnimation,
                AnimationItem.gravityAnimation(45),
                .snapAnimation,
                .textAppearAnimation, .gradientAnimation([UIColor.blue, UIColor.green, UIColor.yellow])]
    }
}
