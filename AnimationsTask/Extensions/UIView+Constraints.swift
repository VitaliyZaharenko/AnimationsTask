//
//  UIView+Constraints.swift
//  AnimationsTask
//
//  Created by vitali on 11/7/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

extension UIView {
    
    func removeConstraints(){
        var superview = self.superview
        while superview != nil {
            for constraint in superview!.constraints {
                if (constraint.firstItem as? UIView) == self || (constraint.secondItem as? UIView) == self {
                    superview!.removeConstraint(constraint)
                    
                }
            }
            superview = superview!.superview
        }
        
        self.removeConstraints(self.constraints)
        //self.translatesAutoresizingMaskIntoConstraints = true
    }
}
