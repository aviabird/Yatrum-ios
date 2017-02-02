//
//  TripState.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation

struct TripState {
    var feedTripIds: [NSNumber]
    var trendingTripIds: [NSNumber]
    var entities: [NSNumber: Trip]
    var selectedTripId: NSNumber?
    var searchTerms: String?
    
    func feedTrips() -> [Trip] {
        return feedTripIds.map { (tripId) -> Trip in
            entities[tripId]!
        }
    }
}


