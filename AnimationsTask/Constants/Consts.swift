//
//  Consts.swift
//  AnimationsTask
//
//  Created by vitali on 11/6/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import Foundation

struct Consts {
    
    struct Cells {
        struct AnimationCell {
            static let reuseIdentifier = "AnimationNameId"
            static let xibName = "AnimationCell"
        }
        
        struct AnimItemWithSlider {
            static let reuseIdentifier = "AnimItemWithSliderId"
            static let xibName = "AnimItemWithSliderCell"
        }
        
        struct AnimItemWithValue {
            static let reuseIdentifier = "AnimItemWithValueId"
            static let xibName = "AnimItemWithValueCell"
        }
    }
    
    
    
    struct FallAnimationController {
        static let storyboardName = "Fall"
        static let storyboardId = "FallAnimationControllerId"
    }
    
    struct ScaleAnimationController {
        static let storyboardName = "Scale"
        static let storyboardId = "ScaleControllerId"
    }
    
    struct UnhookAnimationController {
        static let storyboardName = "Unhook"
        static let storyboardId = "UnhookControllerId"
    }
    
    struct GravityAnimationController {
        static let storyboardName = "Gravity"
        static let storyboardId = "GravityControllerId"
    }
    
    struct SnapAnimationController {
        static let storyboardName = "Snap"
        static let storyboardId = "SnapControllerId"
    }
    
    struct TextAppearAnimationController {
        static let storyboardName = "TextAppear"
        static let storyboardId = "TextAppearControllerId"
    }
}
