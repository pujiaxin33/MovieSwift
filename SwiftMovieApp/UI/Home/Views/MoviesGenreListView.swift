//
//  MoviesGenreListView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct MoviesGenreListView: View {
    @State var viewModel: MoviesGenreListViewModel
    
    var body: some View {
        Group {
            if let movies = viewModel.movies {
                MoviesListView(viewModel: .init(repository: viewModel.repository, movies: movies), naviTitle: "Genre", displaySearch: true)
            } else {
                ProgressView()
            }
        }.onAppear {
            viewModel.loadData()
        }
    }
}

