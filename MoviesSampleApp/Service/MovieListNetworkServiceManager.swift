//
//  MovieListNetworkServiceManager.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 11/02/24.
//

import Foundation
import Combine

// Protocol defining the structure of a service for fetching movies.
protocol MovieServiceProtocol {
    // Fetches a list of movies.
    func getMovies() -> AnyPublisher<[Movie], Error>
}

class MovieService: MovieServiceProtocol {
    private let apiClient = URLSessionAPIClient<MoviesEndpoint>()
    
    func getMovies() -> AnyPublisher<[Movie], Error> {
        return apiClient.request(.getMovies)
    }
}
