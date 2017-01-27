//
//  ApiService.swift
//  TravelApp
//
//  Created by rawat on 27/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit

class TripService: NSObject {

    static let sharedInstance = TripService()
    static var sharedData = SharedData()
    
    func fetchTrips(completion: @escaping ([Trip]) -> () ) {
        let url = NSURL(string: "\(TripService.sharedData.API_URL)/trips.json?page=1")
        
        let configuration = URLSessionConfiguration.default
        
        let urlRequest = URLRequest(url: url as! URL)
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
                return
            }
                
            else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    let responseJson = json as! [String: AnyObject]
                    let tripsArray = responseJson["trips"]
                    
                    var trips = [Trip]()
                    
                    for dictionary in tripsArray as! [[String: AnyObject]] {
                        let trip = Trip()
                        trip.title = dictionary["name"] as! String?
                        trip.numberOfLikes = dictionary["trip_likes_count"] as! NSNumber?
                        trip.thumbnailImageURL = dictionary["thumbnail_image_url"] as! String?
                        trip.isLikedByCurrentUser = true
                        
                        
                        // User Data
                        // ---------------------
                        let userDict = dictionary["user"] as! [String: AnyObject]
                        let user = User()
                        user.name = userDict["name"] as! String?
                        
                        let profilePic = userDict["profile_pic"] as! [String: AnyObject]
                        user.profileImageURL = profilePic["url"] as! String?
                        // --------User Data----------
                        
                        trip.user = user
                        
                        trips.append(trip)
                    }
                    
                    DispatchQueue.main.async {
                         completion(trips)
                    }
                    
                    return
                }
                catch let error as NSError {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
