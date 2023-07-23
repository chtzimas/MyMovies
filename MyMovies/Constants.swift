//
//  Constants.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation

enum Constants {
    enum Api {
        static let popularMoviesUrl = URL(string: "https://api.themoviedb.org/3/movie/popular")
        static let searchMoviesUrl = URL(string: "https://api.themoviedb.org/3/search/movie")
        static let imageBasePath = "https://image.tmdb.org/t/p/w500/"

        enum QueryKey: String {
            case publicKey = "api_key"
            case searchQuery = "query"
        }

        enum QueryValue {
            static let apiKey = "6b2e856adafcc7be98bdf0d8b076851c"
        }
    }
}
