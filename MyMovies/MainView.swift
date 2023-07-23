//
//  MainView.swift
//  MyMovies
//
//  Created by Christos Tzimas on 21/7/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                    .padding(EdgeInsets(top: .small, leading: .medium, bottom: .small, trailing: .medium))
                SearchBarView(text: $viewModel.searchText)
                    .padding(EdgeInsets(top: 0, leading: .medium, bottom: .small, trailing: .medium))
                MoviesView(movies: $viewModel.movies)
                .onAppear {
                    Task {
                        await viewModel.getPopularMovies()
                    }
                }
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text(Wordings.alertErrorTitle),
                    message: Text(Wordings.alertErrorMessage)
                )
            }
            if viewModel.state == .fetchingMovies {
                ProgressView()
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
