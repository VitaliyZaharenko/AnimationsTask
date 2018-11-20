//
//  ViewAppearDisappearAnimationController.swift
//  AnimationsTask
//
//  Created by vitali on 11/13/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit


class ViewAppearDisappearAnimationController: UIViewController {

    
    //MARK: - Views
    @IBOutlet weak var colorView: ColorView!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Actions
    
    
    @IBAction func animate(_ sender: UIButton) {
        
        if(colorView.isVisible){
            colorView.animateDisappear()
        } else {
            colorView.animateAppear()
        }
    }
    
    
}
