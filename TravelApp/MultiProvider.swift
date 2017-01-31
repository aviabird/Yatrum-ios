//
//  MultiProvider.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation
import Moya

let authPlugin = AccessTokenPlugin(token: SharedData.sharedInstance.getToken())
let provider = RxMoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true), authPlugin])
