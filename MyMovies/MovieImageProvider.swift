//
//  MovieImageProvider.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation
import Kingfisher
import SwiftUI

class MovieImageProvider: MovieImageProviderProtocol {
    func getImage(from url: URL?) -> AnyView {
        AnyView(
            KFImage(url)
                .resizable()
                .frame(width: .xxLarge, height: .xxLarge)
                .scaledToFill()
                .cornerRadius(.medium)
                .padding(.medium)
        )
    }
}
