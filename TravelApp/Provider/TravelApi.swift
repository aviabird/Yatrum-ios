//
//  TravelApi.swift
//  TravelApp
//
//  Created by rawat on 30/01/17.
//  Copyright © 2017 Pankaj Rawat. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup
private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let TravelAppProvider = MoyaProvider<TravelApp>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum TravelApp {
    case trips
    case trending_trips
    case trip()
}

extension TravelApp: TargetType {
    public var baseURL: URL { return URL(string: SharedData.sharedInstance.API_URL)! }
    public var path: String {
        switch self {
        case .trips:
            return "/trips"
        case .trending_trips:
            return "/trending/trips"
        case .trip(let id):
            return "/trip/\(id)"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var parameters: [String: Any]? {
        switch self {
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
        case .trip(let id):
            return "{\"name\": \"Any\", \"id\": \(id)}".data(using: String.Encoding.utf8)!
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
