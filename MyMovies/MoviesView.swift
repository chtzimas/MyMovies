//
//  MoviesView.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import SwiftUI

struct MoviesView: View {
    @Binding var movies: [Movie]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: .medium) {
                ForEach(movies) { movie in
                    MovieView(
                        imagePath: movie.imagePath,
                        title: movie.title,
                        averageVote: movie.averageVote,
                        releaseDate: movie.releaseDate,
                        rating: movie.rating,
                        isFavorite: movie.isFavorite
                    )
                }
            }
        }
    }
}
