//
//  MoviesListView.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 11/02/24.
//

import SwiftUI

struct MoviesListView: View {
    // View model for fetching and managing movie data.
    @StateObject var viewModel = MoviesViewModel(userService: MovieService())
    @State private var isLoading = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let movieArray = viewModel.moviesList, !movieArray.isEmpty {
                    List() {
                        ForEach(movieArray, id: \.id) { item in
                            MoviesListRow(moviesModel: item)
                            
                        }
                    }.listStyle(.plain)
                } else {
                    ProgressView("Loading data…")
                        .accessibility(label: Text("Loading movies"))
                }
                
            }
            .task {
                viewModel.fetchMovies()
                
            }.navigationTitle("Movies List")
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
