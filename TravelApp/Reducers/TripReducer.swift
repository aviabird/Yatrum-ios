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
    case let action as SetTrips:
        state.tripFeeds = action.trips
        break
    default:
        break
    }
    
    return state
}

func initialTripState() -> TripState {
    return TripState(tripFeeds: nil, selectedTripId: nil, searchTerms: nil)
}
