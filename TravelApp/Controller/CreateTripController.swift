//
//  CreateTrip.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 24/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class CreateTripController: UIViewController {
    
    override var shouldAutorotate: Bool { return false }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Create Trip"
    }
    
}
