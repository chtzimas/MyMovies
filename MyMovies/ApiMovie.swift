//
//  ApiMovie.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation

struct ApiMovie: Decodable {
    let imagePath: String?
    let title: String?
    let averageVote: Float?
    let releaseDate: String?
    let rating: Float?
}

extension ApiMovie {
    enum CodingKeys: String, CodingKey {
        case imagePath = "poster_path"
        case title = "original_title"
        case averageVote = "vote_average"
        case releaseDate = "release_date"
        case rating = "popularity"
    }
}
