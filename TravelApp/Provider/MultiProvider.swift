//
//  MultiProvider.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation
import Moya

var authPlugin = AccessTokenPlugin(tokenClosure: SharedData.sharedInstance.getToken())
var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true), authPlugin])
