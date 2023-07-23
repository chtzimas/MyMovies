//
//  MovieWebRepository.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Foundation

class MovieWebRepository {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getPopularMovies() async throws -> [ApiMovie]? {
        let endpoint = ApiConvertor.getPopularMovies
        let (data, response) = try await urlSession.data(for: endpoint.getPopularMoviesUrlRequest())
        
        guard let response = (response as? HTTPURLResponse) else { throw ApiError.unknown }
        
        let statusCode = response.statusCode
        switch statusCode {
        case 200:
            do {
                let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                return response.movies
            } catch {
                throw ApiError.decoding
            }
        default:
            throw ApiError.errorCode(statusCode)
        }
    }
    
    func searchMovies(by title: String) async throws -> [ApiMovie]? {
        let endpoint = ApiConvertor.searchMovies(queryText: title)
        let (data, response) = try await urlSession.data(for: endpoint.getSearchMoviesUrlRequest())
        
        guard let response = (response as? HTTPURLResponse) else { throw ApiError.unknown }
        
        let statusCode = response.statusCode
        switch statusCode {
        case 200:
            do {
                let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                return response.movies
            } catch {
                throw ApiError.decoding
            }
        default:
            throw ApiError.errorCode(statusCode)
        }
    }
}
