//
//  Numbers+Random.swift
//  AnimationsTask
//
//  Created by zaharenkov on 13/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import Foundation

extension Double {
    
    static func randomZeroOne() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}
