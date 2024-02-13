//
//  ApiEndPointService.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 11/02/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}

enum MoviesEndpoint: APIEndpoint {
    case getMovies
    
    var baseURL: URL {
        return URL(string: "https://api.sampleapis.com")!
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "/movies/western"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getMovies:
           // return ["Authorization": "Bearer TOKEN"]
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getMovies:
           // return ["page": 1, "limit": 10]
            return nil
        }
    }
}
