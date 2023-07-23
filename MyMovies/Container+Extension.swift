//
//  Container+Extension.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Factory
import Foundation

extension Container {
    var movieWebRepository: Factory<MovieWebRepository> {
        self {
            MovieWebRepository()
        }.shared
    }
    
    var movieImageProvider: Factory<MovieImageProviderProtocol> {
        self {
            MovieImageProvider()
        }.shared
    }
}
