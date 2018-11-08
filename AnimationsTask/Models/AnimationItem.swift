//
//  AnimationItem.swift
//  AnimationsTask
//
//  Created by vitali on 11/7/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import Foundation

enum AnimationItem {
    
    case fallAnimation
    case scaleAnimation
    
    var name: String {
        switch self {
        case .fallAnimation:
            return "Fall Animation"
        case .scaleAnimation:
            return "Scale Animation"
        
        }
    }
    
    static var all: [AnimationItem] {
        return [.fallAnimation, .scaleAnimation]
    }
}
