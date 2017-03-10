//
//  SharedControl.swift
//  TravelApp
//
//  Created by rawat on 22/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class SharedData: NSObject {
    
    var API_URL: String = "http://localhost:3000"
//    var API_URL: String = "https://travel-api-aviabird.herokuapp.com"
//    var API_URL: String = "https://yatrum-api.herokuapp.com"
    var token: String = ""
    static let sharedInstance = SharedData()
    var currentUser: User!
    var homeController: HomeController!
    
    func getToken() -> String {
        if token == "" {
            let data = UserDefaults.standard.object(forKey: "Token") as? String
            if (data != nil) {
                self.token = data!
            }
        }
        
        return self.token
    }
    
    func setToken() {
        UserDefaults.standard.set(self.token, forKey: "Token")
    }
    
    func clearAll() {
        token = ""
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "Token")
    }
    
    func SetCurrentUser(user: User) {
        currentUser = user
    }
    
}
