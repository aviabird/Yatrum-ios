//
//  AuthenticationReducer.swift
//  TravelApp
//
//  Created by Pankaj Rawat on 02/02/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import ReSwift

func authenticationReducer(state: AuthenticationState?, action: Action) -> AuthenticationState {
    let state = state ?? initialAuthenticationState()
    
    switch action {
    case _ as ReSwiftInit:
        break
    default:
        break
    }
    
    return state
}

func initialAuthenticationState() -> AuthenticationState {
    return AuthenticationState(isAuthenticated: false, user: nil, entities: [:], ids: [], selectedUserId: nil, access_token: nil)
}
