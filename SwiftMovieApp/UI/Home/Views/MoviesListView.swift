//
//  MoviesListView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking
import Combine

struct MoviesListView: View {
    let viewModel: MoviesListViewModel
    let naviTitle: String
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    private let publisher: PassthroughSubject<String, Never> = .init()
    
    var body: some View {
        List {
            if isSearching {
                ForEach(viewModel.searchMovies) { movie in
                    MovieCardView(movie: movie)
                }
            } else {
                ForEach(viewModel.movies) { movie in
                    MovieCardView(movie: movie)
                }
            }
        }
        .navigationTitle(naviTitle)
        .if(viewModel.listType.showSearch, transform: { view in
            view.searchable(text: $searchText, isPresented: $isSearching, prompt: Text("Search Any Movie Or Person"))
        })
        .onChange(of: searchText) {
            publisher.send(searchText)
        }
        .onReceive(publisher.filter{ !$0.isEmpty }.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)) { value in
            viewModel.searchMovies(with: value)
        }
        .onAppear {
            viewModel.fetchMovies()
        }
    }
}

struct MovieCardView: View {
    let movie: Movie
    var body: some View {
        NavigationLink(value: movie) {
            HStack {
                MoviePosterView(path: movie.poster_path, urlSize: .medium, size: .medium)
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .foregroundStyle(Color.yellow)
                    
                    HStack {
                        Text(movie.voteAverageText)
                        if let date = movie.release_date {
                            Text(date)
                        }
                    }
                    
                    Text(movie.overview)
                        .lineLimit(3)
                }
            }
        }
    }
}
