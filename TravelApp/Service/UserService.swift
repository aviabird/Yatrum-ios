//
//  UserService.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import Moya

class UserService: NSObject {
    
    static let sharedInstance = UserService()

    func followUser(followedId: NSNumber, completion: @escaping (User) -> () ) {
        provider.request(MultiTarget(UserApi.followUser(followedId))) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? [String: AnyObject] {
                        
                        let user = User(dictionary: json)
                        
                        DispatchQueue.main.async {
                            completion(user)
                            store.dispatch(UpdateTripUser(user: user))
                        }
                    } else {
                        self.showAlert("Travel App Fetch", message: "Unable to fetch from Server")
                    }
                } catch {
                    self.showAlert("Travel App Fetch", message: "Unable to fetch from Server")
                }
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                self.showAlert("Travel App Fetch", message: error.description)
            }
        }
    }
    
    func getUser(userId: NSNumber, completion: @escaping (User) -> () ) {
        provider.request(MultiTarget(UserApi.getUser(userId))) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? [String: AnyObject] {
                        
                        let user = User(dictionary: json)
                        
                        DispatchQueue.main.async {
                            completion(user)
                            store.dispatch(UpdateTripUser(user: user))
                        }
                    } else {
                        self.showAlert("Travel App Fetch", message: "Unable to fetch from Server")
                    }
                } catch {
                    self.showAlert("Travel App Fetch", message: "Unable to fetch from Server")
                }
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                self.showAlert("Travel App Fetch", message: error.description)
            }
        }
    }
    
    func fetchUserFollowers(userId: NSNumber, completion: @escaping ([User]) -> () ) {
        provider.request(MultiTarget(UserApi.userFollowers(userId))) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? [[String: AnyObject]] {
                        
                        var users = [User]()
                        
                        
                        for dictionary in json {
                            let user = User(dictionary: dictionary)
                            users.append(user)
                        }
                        
                        DispatchQueue.main.async {
                            completion(users)
                        }
                    } else {
                        self.showAlert("User Follower Fetch", message: "Unable to fetch from Server")
                    }
                } catch {
                    self.showAlert("User Follower Fetch", message: "Unable to fetch from Server")
                }
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                self.showAlert("Travel App Fetch", message: error.description)
            }
        }
    }


    
    fileprivate func showAlert(_ title: String, message: String) {
        //        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        //        alertController.addAction(ok)
        //        present(alertController, animated: true, completion: nil)
        print(title, message)
    }
}
