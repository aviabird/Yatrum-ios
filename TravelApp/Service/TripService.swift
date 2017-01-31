//
//  ApiService.swift
//  TravelApp
//
//  Created by rawat on 27/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import UIKit
import Moya

class TripService: NSObject {

    static let sharedInstance = TripService()
    static var sharedData = SharedData()
    let baseUrl = TripService.sharedData.API_URL
    
    func fetchTripsFeed(completion: @escaping ([Trip]) -> () ) {
        fetchFeedForUrlString(urlTargetType: TravelApp.trips, completion: completion)
    }
    
    func fetchTrendingTripsFeed(completion: @escaping ([Trip]) -> () ) {
        fetchFeedForUrlString(urlTargetType: TravelApp.trendingTrips, completion: completion)
    }
    
    func likeTrip(tripId: NSNumber, completion: @escaping (Trip) -> () ) {
        provider.request(MultiTarget(TravelApp.likeTrip(tripId))) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? [String: AnyObject] {
                        
                        let trip = Trip(dictionary: json)
                        
                        DispatchQueue.main.async {
                            completion(trip)
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
    
    func fetchFeedForUrlString(urlTargetType: TargetType, completion: @escaping ([Trip]) -> () ) {
        provider.request(MultiTarget(urlTargetType)) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? [String: AnyObject] {
                        
                        let tripsArray = json["trips"]
    
                        var trips = [Trip]()

                        for dictionary in tripsArray as! [[String: AnyObject]] {
                            let trip = Trip(dictionary: dictionary)
                            trips.append(trip)
                        }

                        DispatchQueue.main.async {
                            completion(trips)
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
    
    fileprivate func showAlert(_ title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(ok)
//        present(alertController, animated: true, completion: nil)
        print(title, message)
    }
}
