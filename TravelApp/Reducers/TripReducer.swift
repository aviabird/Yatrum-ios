//
//  TripReducer.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 01/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import ReSwift

func tripReducer(state: TripState?, action: Action) -> TripState {
    var state = state ?? initialTripState()
    
    switch action {
    case _ as ReSwiftInit:
        break
    case let action as SetFeedTrips:
        let trips = action.trips
        
        let newIds = trips.filter({ (trip) -> Bool in
            !(state.feedTripIds.contains(trip.id!))
        }).map({ (trip) -> NSNumber in
            trip.id!
        })
        
        state.feedTripIds.append(contentsOf: newIds)
        
        trips.forEach({ (trip) in
            state.entities[trip.id!] = trip
        })
        
        break
    default:
        break
    }
    
    return state
}

func initialTripState() -> TripState {
    return TripState(feedTripIds: [], trendingTripIds: [], entities: [:], selectedTripId: nil, searchTerms: nil)
}
