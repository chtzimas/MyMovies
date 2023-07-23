//
//  ApiConvertor.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation

enum ApiConvertor {
    case getPopularMovies
    case searchMovies(queryText: String)
    
    private var popularMoviesBaseURL: URL? {
        Constants.Api.popularMoviesUrl
    }
    
    private var searchMoviesBaseURL: URL? {
        Constants.Api.searchMoviesUrl
    }

    func getPopularMoviesUrlRequest() throws -> URLRequest {
        guard let url = popularMoviesBaseURL?.appendingParams(params: queryParams) else {
            throw ApiError.invalidUrl
        }
        return URLRequest(url: url)
    }
    
    func getSearchMoviesUrlRequest() throws -> URLRequest {
        guard let url = searchMoviesBaseURL?.appendingParams(params: queryParams) else {
            throw ApiError.invalidUrl
        }
        return URLRequest(url: url)
    }
    
    private var queryParams: [Constants.Api.QueryKey: String] {
        switch self {
        case .getPopularMovies:
            return [.publicKey: Constants.Api.QueryValue.apiKey]
        case .searchMovies(let searchQuery):
            return [.searchQuery: searchQuery.replacingOccurrences(of: " ", with: "+"), .publicKey: Constants.Api.QueryValue.apiKey]
        }
    }
}

private extension URL {
    func appendingParams(params: [Constants.Api.QueryKey: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key.rawValue, value: element.value) }
        return components?.url
    }
}
