//
//  MoviesViewModel.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import Combine
import Factory
import SwiftUI

class MoviesViewModel: ObservableObject {
    // MARK: Properties
    @Injected(\.movieWebRepository) private var repository
    
    @Published var movies = [Movie]()
    @Published var showErrorAlert = false
    @Published var searchText = ""
    @Published private(set) var state: State = .none
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    
    // MARK: State
    enum State {
        case fetchingMovies
        case moviesFetched
        case fetchingMoviesFailed
        case searchingMovies
        case moviesSearched
        case searchingMoviesFailed
        case none
    }
    
    // MARK: Init
    init() {
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue(label: "moviesSearch", qos: .userInteractive))
            .compactMap { searchText -> String? in
                searchText.isEmpty ? nil : searchText
            }
            .flatMap { [weak self] searchText -> AnyPublisher<[Movie], Never> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                return self.getSearchForMoviesPublisher(by: searchText)
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }
    
    // MARK: Api Calls
    func getPopularMovies() async {
        do {
            await MainActor.run {
                state = .fetchingMovies
            }
            let apiMovies = try await repository.getPopularMovies() ?? [ApiMovie]()
            await MainActor.run {
                state = .moviesFetched
                movies = mapMovies(from: apiMovies)
            }
        } catch {
            debugPrint(error)
            await MainActor.run {
                state = .fetchingMoviesFailed
                showErrorAlert = true
            }
        }
    }
    
    private func searchForMovies(by title: String) async -> [Movie] {
        var apiMovies = [ApiMovie]()
        do {
            await MainActor.run {
                state = .searchingMovies
            }
            apiMovies = try await repository.searchMovies(by: title) ?? [ApiMovie]()
            await MainActor.run {
                state = .moviesSearched
            }
        } catch {
            debugPrint(error)
            await MainActor.run {
                state = .searchingMoviesFailed
                showErrorAlert = true
            }
        }
        return mapMovies(from: apiMovies)
    }
    
    // MARK: Helpers
    private func getSearchForMoviesPublisher(by title: String) -> AnyPublisher<[Movie], Never> {
        Future<[Movie], Never> { promise in
            Task {
                let movies = await self.searchForMovies(by: title)
                promise(.success(movies))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func mapMovies(from apiMovies: [ApiMovie]) -> [Movie] {
        apiMovies.map {
            Movie(
                id: UUID(),
                imagePath: Constants.Api.imageBasePath + ($0.imagePath ?? ""),
                title: $0.title ?? "",
                averageVote: $0.averageVote ?? 0,
                releaseDate: $0.releaseDate ?? "",
                rating: $0.rating ?? 0,
                isFavorite: false
            )
        }
    }
}
