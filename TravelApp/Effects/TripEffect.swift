//
//  TripEffect.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 02/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import ReSwift

func FetchTripsFeed(state: AppState, store: Store<AppState>) -> Action? {
    TripService.sharedInstance.fetchTripsFeed { (trips: [Trip]) in
        DispatchQueue.main.async {
            store.dispatch(SetFeedTrips(trips: trips))
        }
    }
    
    return nil
}

func FetchTrendingTripsFeed(state: AppState, store: Store<AppState>) -> Action? {
    TripService.sharedInstance.fetchTrendingTripsFeed { (trips: [Trip]) in
        DispatchQueue.main.async {
            store.dispatch(SetTrendingTrips(trips: trips))
        }
    }
    
    return nil
}
