//
//  ApiError.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case decoding
    case errorCode(Int)
    case unknown
}
