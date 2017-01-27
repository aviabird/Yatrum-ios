//
//  AuthService.swift
//  TravelApp
//
//  Created by rawat on 27/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class AuthService: NSObject {

    static let sharedInstance = AuthService()
    static var sharedData = SharedData()
    
    func login(email: String, password: String, loginController: LoginController) {
        let url = URL(string: "\(AuthService.sharedData.API_URL)/authenticate")!
        let params = ["email": "\(email)", "password": "\(password)"]
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                        if let error = ((jsonResult["error"] as? NSDictionary)?["user_authentication"] as? NSArray)?[0]{
                            DispatchQueue.main.sync(execute: {
                                loginController.createAlert(title: "Error", message: "\(error)")
                            })
                        }else {
                            if let authToken = jsonResult["auth_token"] as? String {
                                AuthService.sharedData.token = authToken
                                AuthService.sharedData.setToken()
                                DispatchQueue.main.sync(execute: {
                                    loginController.dismiss(animated: true, completion: {
                                        loginController.homeController?.fetchTrips()
                                    })
                                })
                            }
                        }
                    } catch {
                        DispatchQueue.main.sync(execute: {
                            loginController.createAlert(title: "Data Incorrect", message: "Please Check The data")
                        })
                    }
                }
            }
        })
        task.resume()
    }
    
    func register(email: String, password: String, confirmPassword: String, loginController: LoginController) {
        let url = URL(string: "\(AuthService.sharedData.API_URL)/users/create")!
        let params = ["user": ["email": "\(email)", "password": "\(password)", "password_confirmation": "\(confirmPassword)"]]
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let data = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                        //                                print(jsonResult["password_confirmation"])
                        if let error = (jsonResult["password_confirmation"] as? NSArray)?[0] {
                            DispatchQueue.main.sync(execute: {
                                loginController.createAlert(title: "Error", message: "\(error)")
                            })
                        }else {
                            DispatchQueue.main.sync(execute: {
                                let alert = UIAlertController(title: "Successfull Sign Up", message: "Welcome To Trip Diary", preferredStyle: UIAlertControllerStyle.alert)
                                
                                alert.addAction(UIAlertAction(title: "Let's Start", style: .default, handler: { (action) in
                                    loginController.handleLogin()
                                }))
                                
                                loginController.present(alert, animated: true, completion: nil)
                            })
                        }
                    } catch {
                        DispatchQueue.main.sync(execute: {
                            loginController.createAlert(title: "Data Incorrect", message: "Please Check The data")
                        })
                    }
                }
            }
        })
        task.resume()
    }
}
