//
//  Endpoint.swift
//  GorillaTest
//
//  Created by David Figueroa on 1/11/21.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: String { get }
    var absoluteString: String { get }
}
