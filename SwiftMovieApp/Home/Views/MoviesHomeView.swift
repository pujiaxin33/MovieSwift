//
//  ContentView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI
import Networking

struct MoviesHomeView: View {
    
    @State var viewModel: MoviesHomeViewModel
    @State private var navigation = Navigation()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                ForEach(MoviesMenu.allCases, id: \.self) { menu in
                    if menu == .genres {
                        if !viewModel.genres.isEmpty {
                            genresList(genres: viewModel.genres)
                        }
                    } else {
                        if let movies = viewModel.movies[menu] {
                            moviesList(menu: menu, movies: movies)
                        }
                    }
                }
            }.navigationDestination(for: Movie.self) { movie in
                MovieDetailView(viewModel: .init(movie: movie))
            }
            .navigationDestination(for: MovieListPath.self, destination: { path in
                MoviesListView(naviTitle: path.naviTitle, movies: path.movies)
            })
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.automatic)
        }.environment(\.navigation, navigation)
        
    }
    
    func moviesList(menu: MoviesMenu, movies: [Movie]) -> some View {
        Section {
            VStack {
                Text(menu.title())
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(movies) { movie in
                            NavigationLink(value: movie) {
                                MoviePosterView(path: movie.poster_path, urlSize: .medium, size: .medium)
                            }
                        }
                    }
                }.frame(height: 120)
            }
        }
    }
    
    func genresList(genres: [Genre]) -> some View {
        Section {
            VStack {
                ForEach(genres) { genre in
                    Text(genre.name)
                }
            }
        }
    }
}

#Preview {
    MoviesHomeView(viewModel: .init())
}
