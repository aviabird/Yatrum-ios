//
//  TripActions.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 01/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation
import ReSwift

struct SetFeedTrips: Action {
    let trips: [Trip]
}

struct SetTrendingTrips: Action {
    let trips: [Trip]
}

struct UpdateTrips: Action {
    let trips: [Trip]
}

struct SelectTrip: Action {
    let tripId: NSNumber
}

struct UpdateTripUser: Action {
    let user: User
}
