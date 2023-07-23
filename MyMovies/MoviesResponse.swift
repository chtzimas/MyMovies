//
//  MoviesResponse.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation

struct MoviesResponse: Decodable {
    let movies: [ApiMovie]?
}

extension MoviesResponse {
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
