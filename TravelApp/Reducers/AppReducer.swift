//
//  AppReducer.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 02/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        authenticationState: authenticationReducer(state: state?.authenticationState, action: action),
        tripState: tripReducer(state: state?.tripState, action: action)
    )
}


