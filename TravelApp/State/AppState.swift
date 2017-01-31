//
//  AppState.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    var authenticationState: AuthenticationState
    var tripState: TripState
}
