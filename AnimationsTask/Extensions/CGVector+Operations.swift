//
//  CGVector+Operations.swift
//  AnimationsTask
//
//  Created by vitali on 11/12/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//


import CoreGraphics

extension CGVector {
    
    static func + (left: CGVector, right: CGVector) -> CGVector {
        return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
    }
    
    static func - (left: CGVector, right: CGVector) -> CGVector {
        return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
    }
    
    func magnitude() -> CGFloat {
        return sqrt(dx * dx + dy * dy)
    }
    
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }
}
