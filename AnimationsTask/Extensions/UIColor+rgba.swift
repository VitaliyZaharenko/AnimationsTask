//
//  UIColor+rgba.swift
//  AnimationsTask
//
//  Created by zaharenkov on 13/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

extension UIColor {
    
    var r: CGFloat {
        get {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return red
        }
    }
    var g: CGFloat {
        get {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return green
        }
    }
    var b: CGFloat {
        get {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return blue
        }
    }
    var a: CGFloat {
        get {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return alpha
        }
    }
}
