//
//  ViewController.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 21/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var sharedData = SharedData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if sharedData.getToken() == "" {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            print("Trips Page")
        }
    }
    
    func handleLogout() {
        
        sharedData.clearAll()
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
    }


}

