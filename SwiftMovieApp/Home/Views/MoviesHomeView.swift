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
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(for: MovieListPath.self, destination: { path in
                MoviesListView(naviTitle: path.naviTitle, movies: path.movies)
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: PeopleListPath.self, destination: { path in
                PeopleListView(naviTitle: path.naviTitle, peoples: path.peoples)
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: People.self, destination: { people in
                PeopleDetailView()
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: Genre.self, destination: { genre in
                MoviesGenreListView(viewModel: .init(genre: genre))
                    .toolbar(.hidden, for: .tabBar)
            })
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
                Text(menu.title())
                
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

#Preview {
    MoviesHomeView(viewModel: .init())
}
