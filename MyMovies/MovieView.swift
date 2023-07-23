//
//  MovieView.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Factory
import SwiftUI

struct MovieView: View {
    @Injected(\.movieImageProvider) private var imageProvider
    
    let imagePath: String
    let title: String
    let averageVote: Float
    let releaseDate: String
    let rating: Float
    let isFavorite: Bool
    
    var body: some View {
        HStack {
            imageProvider.getImage(from: URL(string: imagePath))
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                Text("\(Wordings.averageVotePlaceholderText): \(averageVote, specifier: averageVote.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f") / 10")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                Text("\(Wordings.ratingPlaceholderText): \(rating, specifier: "%.0f")")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                Text("\(Wordings.releaseDatePlaceholderText): \(releaseDate)")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top, .medium)
            Spacer()
            VStack(alignment: .trailing) {
                Button {
                    // addToFavorites
                } label: {
                    Image(isFavorite ? "FavoriteIcon" : "NotFavoriteIcon")
                }
                Spacer()
            }
            .padding(.medium)
        }
        .background(Color.randomColor().opacity(0.2))
        .cornerRadius(.medium)
        .padding(.horizontal, .medium)
    }
}
