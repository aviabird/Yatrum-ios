//
//  TripState.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation

enum TripType {
    case trendingTrips
    case feedTrips
}

struct TripState {
    var feedTripIds: [NSNumber]
    var trendingTripIds: [NSNumber]
    var entities: [NSNumber: Trip]
    var selectedTripId: NSNumber?
    var searchTerms: String?
    
    func feedTrips() -> [Trip] {
        return tripsForIds(tripIds: feedTripIds)
    }
    
    func trendingTrips() -> [Trip] {
        return tripsForIds(tripIds: trendingTripIds)
    }
    
    private func tripsForIds(tripIds: [NSNumber]) -> [Trip] {
        return tripIds.map { (tripId) -> Trip in
            entities[tripId]!
        }
    }
    
    mutating func pushTrips(tripType: TripType, trips: [Trip]) {
        // Pushes data to entities based on tripType
        var tripIds: [NSNumber]
        
        switch tripType {
        case TripType.feedTrips:
            tripIds = self.feedTripIds
            break
        case TripType.trendingTrips:
            tripIds = self.trendingTripIds
            break
        }
        
        let newIds = trips.filter({ (trip) -> Bool in
            !(tripIds.contains(trip.id!))
        }).map({ (trip) -> NSNumber in
            trip.id!
        })
        
        switch tripType {
        case TripType.feedTrips:
            self.feedTripIds.append(contentsOf: newIds)
            break
        case TripType.trendingTrips:
            self.trendingTripIds.append(contentsOf: newIds)
            break
        }
        
        trips.forEach({ (trip) in
            self.entities[trip.id!] = trip
        })
    }
}


