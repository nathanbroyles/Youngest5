//
//  DarkNavigationController.swift
//  Youngest
//
//  Created by Nathan Broyles on 12/8/19.
//  Copyright © 2019 DeadPixel. All rights reserved.
//

import UIKit

class DarkNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
    }
}
