//
//  AnimItemWithValueCell.swift
//  AnimationsTask
//
//  Created by zaharenkov on 08/11/2018.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class AnimItemWithValueCell: UITableViewCell {
    
    //MARK: - Views
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var angleTextField: UITextField!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        print("Initialized")
    }
    
}
