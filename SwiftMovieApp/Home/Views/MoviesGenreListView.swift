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
                MoviesListView(naviTitle: "Genre", movies: movies)
            } else {
                ProgressView()
            }
        }.onAppear {
            viewModel.loadData()
        }
    }
}

