//
//  Movie.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation

struct Movie: Identifiable {
    let id: UUID
    let imagePath: String
    let title: String
    let averageVote: Float
    let releaseDate: String
    let rating: Float
    let isFavorite: Bool
}
