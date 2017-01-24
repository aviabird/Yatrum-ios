//
//  BottomTabBarController.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 24/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class BottomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup custom view controller
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeController(collectionViewLayout: layout)
        let tripsController = UINavigationController(rootViewController: homeController)
        tripsController.tabBarItem.title = "Feeds"
        tripsController.tabBarItem.image = UIImage(named: "feeds")
        
        viewControllers = [
            tripsController,
            createDummyControllerWithTitle(title: "Trending", imageName: "trending"),
            createDummyControllerWithTitle(title: "Near Me", imageName: "near-me"),
            createDummyControllerWithTitle(title: "Notifications", imageName: "notifications"),
            createDummyControllerWithTitle(title: "Me", imageName: "my-trips")
        ]
    }
    
    private func createDummyControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.view.backgroundColor = UIColor.white
        navController.navigationItem.title = title
        
        return navController
    }
}
