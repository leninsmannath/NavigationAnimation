//
//  LaunchVC.swift
//  HalfFrame
//
//  Created by vijay on 2/22/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        radialPushViewController(SecondViewController())
        
        
    }
    
}
