//
//  MoviesListRow.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 11/02/24.
//

import SwiftUI

struct MoviesListRow: View {
    /// Model representing the movie data.
    let moviesModel: Movie
    /// Size of the movie poster image.
    let imageSize: CGFloat = 100
    var body: some View {
        HStack {
            if let urlString = moviesModel.posterURL, let finalUrl = URL(string:urlString ) {
                AsyncImage(url: finalUrl ) {
                    phase in
                    if let image = phase.image {
                        //Display the loaded image
                        image.resizable().scaledToFill().frame(width: imageSize, height: imageSize).cornerRadius(5).clipped()
                        
                    } else if phase.error != nil {
                        //Display a placeHolder when Loading failed
                        Image(systemName: "photo").resizable().frame(width: imageSize, height: imageSize).clipped()
                        
                    } else {
                        //Display a placeholder while loading
                        ProgressView().frame(width: imageSize, height: imageSize)
                    }
                }
            } else {
                Color.gray.frame(width: imageSize, height: imageSize)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(moviesModel.title ?? "")
                
            }
        }
        
    }
}

struct MoviesListRow_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListRow(moviesModel: Movie(id: 1, title: "ddd", posterURL: "https://picsum.photos/200", imdbId: ""))
    }
}
