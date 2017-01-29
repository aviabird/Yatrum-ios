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
    let baseUrl = TripService.sharedData.API_URL
    
    func fetchTripsFeed(completion: @escaping ([Trip]) -> () ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trips.json", completion: completion)
    }
    
    func fetchTrendingTripsFeed(completion: @escaping ([Trip]) -> () ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending/trips", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Trip]) -> () ) {
        let url = NSURL(string: urlString)
        
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
                        trip.name = dictionary["name"] as! String?
                        trip.trip_likes_count = dictionary["trip_likes_count"] as! NSNumber?
                        trip.thumbnail_image_url = dictionary["thumbnail_image_url"] as! String?
                        trip.is_liked_by_current_user = (dictionary["is_liked_by_current_user"] as! Bool?)!
                        
                        
                        // User Data
                        // ---------------------
                        let userDict = dictionary["user"] as! [String: AnyObject]
                        let user = User()
                        user.name = userDict["name"] as! String?
                        user.is_followed_by_current_user = userDict["is_followed_by_current_user"] as! Bool?
                        
                        let profilePicDict = userDict["profile_pic"] as! [String: AnyObject]
                        let profile_pic = ProfilePic()
                        profile_pic.public_id = profilePicDict["public_id"] as! String?
                        profile_pic.url = profilePicDict["url"] as! String?
                        
                        user.profile_pic = profile_pic
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
