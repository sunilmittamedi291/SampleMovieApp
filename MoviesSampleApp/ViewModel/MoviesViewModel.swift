//
//  MoviesViewModel.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 11/02/24.
//

import Foundation
import Combine
class MoviesViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let movieService: MovieServiceProtocol
    @Published var moviesList: [Movie] = []
    
    init(userService: MovieServiceProtocol) {
        self.movieService = userService
    }
    
    func fetchMovies() {
        movieService.getMovies()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { data in
            
        }, receiveValue: {[weak self] data in
            
            
            self?.moviesList = data
        }).store(in: &cancellables)
    }
}
