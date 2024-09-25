//
//  ContentView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI
import Networking

struct MoviesHomeView: View {
    
    let viewModel: MoviesHomeViewModel
    
    var body: some View {
        NavigationStack {
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
                MovieDetail(movie: movie)
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.automatic)
        }
        
    }
    
    func moviesList(menu: MoviesMenu, movies: [Movie]) -> some View {
        Section {
            VStack {
                Text(menu.title())
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(movies) { movie in
                            if let path = movie.poster_path {
                                NavigationLink(value: movie) {
                                    AsyncImage(url: ImageService.posterUrl(path: path, size: .medium)) { image in
                                        image.resizable()
                                            .renderingMode(.original)
                                            .posterStyle(loaded: true, size: .medium)
                                    } placeholder: {
                                        Color.green.posterStyle(loaded: true, size: .medium)
                                    }
                                }
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
