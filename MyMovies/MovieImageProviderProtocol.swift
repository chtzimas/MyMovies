//
//  MovieImageProviderProtocol.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation
import SwiftUI

protocol MovieImageProviderProtocol {
    func getImage(from url: URL?) -> AnyView
}
