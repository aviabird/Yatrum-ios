//
//  AuthenticationState.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

struct AuthenticationState {
    var isAuthenticated: Bool?
    var user: User?
    var entities: [String: User]?
    var ids: [String]?
    var selectedUserId: String?
    var access_token: String?
}

