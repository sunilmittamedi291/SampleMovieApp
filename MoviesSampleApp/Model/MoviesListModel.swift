//
//  MoviesListModel.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 11/02/24.
//

import Foundation
struct Movie: Identifiable, Codable {
    let id: Int?
    let title: String?
    let posterURL: String?
    let imdbId: String?
}
