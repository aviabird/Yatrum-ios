//
//  TripActions.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 01/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation
import ReSwift

func FetchTripsFeed(state: AppState, store: Store<AppState>) -> Action? {
    TripService.sharedInstance.fetchTripsFeed { (trips: [Trip]) in
        DispatchQueue.main.async {
            store.dispatch(SetTrips(trips: trips))
        }
    }
    
    return nil
}

struct SetTrips: Action {
    let trips: [Trip]
}
