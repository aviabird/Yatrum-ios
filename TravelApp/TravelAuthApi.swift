//
//  AuthProvider.swift
//  TravelApp
//
//  Created by rawat on 31/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation
import Moya

let AuthProvider = MoyaProvider<TravelAppAuth>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

public enum TravelAppAuth {
    case authenticate(String, String)
    case register(String, String, String)
    case auth_user
}

extension TravelAppAuth: TargetType {
    public var baseURL: URL { return URL(string: SharedData.sharedInstance.API_URL)! }
    public var path: String {
        switch self {
        case .authenticate:
            return "/authenticate"
        case .register:
            return "/users/create"
        case .auth_user:
            return "users/auth_user"
        }
    }
    public var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    public var parameters: [String: Any]? {
        switch self {
        case .authenticate(let email, let password):
            return ["email": email, "password": password]
        case .register(let email, let password, let confirmPassword):
            return ["user": ["email": email, "password": password, "password_confirmation": confirmPassword]]
        default:
            return nil
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        return .request
    }
    public var validate: Bool {
        switch self {
        default:
            return false
        }
    }
    public var sampleData: Data {
        switch self {
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
}
