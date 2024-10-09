//
//  ContentView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI
import Networking

struct MoviesHomeView: View {
    
    let coordinator: MoviesHomeCoordinator
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
            }
            .registerMoviesNavigationDestinations(with: coordinator)
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                viewModel.loadData()
            }
        }.environment(\.navigation, navigation)
        
    }
    
    func moviesList(menu: MoviesMenu, movies: [Movie]) -> some View {
        Group {
            VStack(alignment: .leading) {
                SeeAllHeaderView(title: menu.title()) { navi in
                    
                }
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 15) {
                        ForEach(movies) { movie in
                            MoviePosterView(path: movie.poster_path, urlSize: .medium, size: .medium)
                                .onTapGesture {
                                    navigation.path.append(movie)
                                }
                        }
                    }
                }
            }
        }
    }
    
    func genresList(genres: [Genre]) -> some View {
        Group {
            ForEach(genres) { genre in
                NavigationLink(value: genre) {
                    Text(genre.name)
                }
            }
        }
    }
}

