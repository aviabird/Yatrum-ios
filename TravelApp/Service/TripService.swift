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
                        let trip = Trip(dictionary: dictionary)
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
