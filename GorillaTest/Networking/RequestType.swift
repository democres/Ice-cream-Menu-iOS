//
//  AppConfigEndpoint.swift
//  GorillaTest
//
//  Created by David Figueroa on 1/11/21.
//

import Foundation

enum RequestType {
    case getConfig
    case getFlavors
    case getToppings
}

extension RequestType: Endpoint {
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "gorilla-challenges.herokuapp.com"
        }
    }
    
    var path: String {
        switch self {
        case .getConfig:
            return "/icecream/config"
        case .getFlavors:
            return "/icecream/flavors"
        case .getToppings:
            return "/icecream/toppings"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var absoluteString: String {
        switch self {
        default:
            return self.scheme + "://" + self.baseURL + self.path
        }
    }
}
