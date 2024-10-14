//
//  ContentView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI
import Networking

struct MoviesHomeView: View {
    
    enum HomeMode {
        case list, grid
        
        func icon() -> String {
            switch self {
            case .list: return "rectangle.3.offgrid.fill"
            case .grid: return "rectangle.grid.1x2"
            }
        }
    }
    
    let coordinator: MoviesHomeCoordinator
    @State var viewModel: MoviesHomeViewModel
    @State private var navigation = Navigation()
    @State private var selectedMenu: MoviesMenu = .nowPlaying
    @State var homeMode: HomeMode = .list
    
    private var swapHomeButton: some View {
        Button(action: {
            self.homeMode = self.homeMode == .grid ? .list : .grid
        }) {
            HStack {
                Image(systemName: self.homeMode.icon()).imageScale(.medium)
            }.frame(width: 30, height: 30)
        }
    }
    
    @ViewBuilder
    var homeAsList: some View {
        let _ = Self._printChanges()
        TabView(selection: $selectedMenu) {
            ForEach(MoviesMenu.allCases, id: \.self) { menu in
                if menu == .genres {
                    GenreListView(genres: viewModel.genres)
                        .tag(menu)
                } else {
                    coordinator.makeMoviesListView(path: .init(listType: .local, naviTitle: menu.title(), movies: viewModel.movies[menu] ?? []))
                        .tag(menu)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    
    var homeAsGrid: some View {
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
    }
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            Group {
                if homeMode == .list {
                    homeAsList
                } else {
                    homeAsGrid
                }
            }
            .registerMoviesNavigationDestinations(with: coordinator)
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(homeMode == .list ? .inline : .automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    swapHomeButton
                }
            }
            .onFirstAppear {
                viewModel.loadData()
            }
        }.environment(\.navigation, navigation)
        
    }
    
    func moviesList(menu: MoviesMenu, movies: [Movie]) -> some View {
        Group {
            VStack(alignment: .leading) {
                SeeAllHeaderView(title: menu.title()) { navi in
                    navi.path.append(MovieListPath(listType: .menu(menu), naviTitle: menu.title(), movies: movies))
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
                NavigationLink(value: MovieListPath(listType: .genre(genre), naviTitle: "Genre", movies: [])) {
                    Text(genre.name)
                }
            }
        }
    }
}

