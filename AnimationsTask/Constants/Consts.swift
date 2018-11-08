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
    }
    
    
    
    struct FallAnimationController {
        static let storyboardName = "Fall"
        static let storyboardId = "FallAnimationControllerId"
    }
    
    struct ScaleAnimationController {
        static let storyboardName = "Scale"
        static let storyboardId = "ScaleControllerId"
    }
}
