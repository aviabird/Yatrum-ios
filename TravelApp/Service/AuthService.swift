//
//  AuthService.swift
//  TravelApp
//
//  Created by rawat on 27/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import Moya

class AuthService: NSObject {

    static let sharedInstance = AuthService()
    static var sharedData = SharedData()
    
    func login(email: String, password: String, loginController: LoginController) {
        provider.request(MultiTarget(UserApi.authenticate(email, password))) { result in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                    
                    if let error = ((jsonResult["error"] as? NSDictionary)?["user_authentication"] as? NSArray)?[0]{
                        loginController.createAlert(title: "Error", message: "\(error)")
                    }else {
                        if let authToken = jsonResult["auth_token"] as? String {
                            SharedData.sharedInstance.token = authToken
                            SharedData.sharedInstance.setToken()
                            SharedData.sharedInstance.SetCurrentUser(user: User(dictionary: jsonResult["user"] as! [String: AnyObject]))
                            
                            self.refreshProvider()
                            
                            loginController.dismiss(animated: true, completion: nil)
                        }
                    }
                } catch {
                    loginController.createAlert(title: "Authentication", message: "Please Check The data")
                }
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                loginController.createAlert(title: "Authentication Error", message: error.description)
            }
        }
    }
    
    func register(email: String, password: String, confirmPassword: String, loginController: LoginController) {
        provider.request(MultiTarget(UserApi.register(email, password, confirmPassword))) { result in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                    
                    if let error = ((jsonResult["error"] as? NSArray)) {
                        loginController.createAlert(title: "Error", message: error.componentsJoined(by: "\r"))
                    }else {
                        let alert = UIAlertController(title: "Successfull Sign Up", message: "Welcome To Trip Diary", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Let's Start", style: .default, handler: { (action) in
                            loginController.handleLogin()
                        }))
                        
                        loginController.present(alert, animated: true, completion: nil)
                    }
                } catch {
                    loginController.createAlert(title: "Authentication", message: "Please Check The data")
                }
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                loginController.createAlert(title: "Authentication Error", message: error.description)
            }
        }
    }
    
    func auth_user() -> User {
        var user: User = User(dictionary: [:])
        
        provider.request(MultiTarget(UserApi.auth_user)) { result in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
                    
                    if let error = ((jsonResult["error"] as? String)) {
                        print(error)
                    }else {
                        user = User(dictionary: jsonResult as! [String: AnyObject])
                        SharedData.sharedInstance.SetCurrentUser(user: user)
                    }
                } catch {
                    print("Api Error")
                }
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                print("Auth User Error", error.description)
            }
        }
        
        return user
        
    }
    
    private func refreshProvider() {
        authPlugin = AccessTokenPlugin(tokenClosure: SharedData.sharedInstance.getToken())
        provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true), authPlugin])
    }
    
}
