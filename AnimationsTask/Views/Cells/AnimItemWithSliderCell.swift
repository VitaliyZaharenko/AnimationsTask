//
//  AnimationItemWithSliderCell.swift
//  AnimationsTask
//
//  Created by zaharenkov on 08/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class AnimItemWithSliderCell: UITableViewCell {

    //MARK: - Views
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var scaleFactorSlider: UISlider!
    @IBOutlet weak var scaleFactorLabel: UILabel!
    
    //MARK: - Properties
    
    weak var delegate: ScaleAnimationDelegate?
    
    //MARK: - Actions
    
    @IBAction func valueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        scaleFactorLabel.text = String(format: "%.2f", sender.value)
        if let touch = event.allTouches?.first {
            switch touch.phase {
            case .ended:
                delegate?.setScale(sender.value)
            default:
                return
            }
        }
    }
}
