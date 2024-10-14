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
    enum SearchFilter: Int {
        case movies, peoples
    }
    
    let viewModel: MoviesListViewModel
    let naviTitle: String
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var selectedSearchFilter: Int = SearchFilter.movies.rawValue
    
    private let publisher: PassthroughSubject<String, Never> = .init()
    
    var body: some View {
        let _ = Self._printChanges()
        List {
            if isSearching {
                Picker(selection: $selectedSearchFilter) {
                    Text("Movies").tag(SearchFilter.movies.rawValue)
                    Text("Peoples").tag(SearchFilter.peoples.rawValue)
                } label: {
                    Text("")
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if selectedSearchFilter == SearchFilter.movies.rawValue {
                    if !viewModel.searchKeywords.isEmpty {
                        Section {
                            ForEach(viewModel.searchKeywords) { keyword in
                                NavigationLink(value: MovieListPath(listType: .keyword(keyword.name), naviTitle: keyword.name, movies: [])) {
                                    Text(keyword.name)
                                }
                            }
                        } header: {
                            Text("Keywords")
                        }
                    }
                    
                    if !viewModel.searchMovies.isEmpty {
                        Section {
                            ForEach(viewModel.searchMovies) { movie in
                                MovieCardView(movie: movie)
                            }
                        } header: {
                            Text("Results for \(searchText)")
                        }
                    }
                    
                } else {
                    ForEach(viewModel.searchPeoples) { people in
                        PeopleCardView(people: people)
                    }
                }
                
            } else {
                let _ = print("create movies list")
                ForEach(viewModel.movies) { movie in
                    MovieCardView(movie: movie)
                }
            }
        }
        .navigationTitle(naviTitle)
        .if(viewModel.listType.showSearch, transform: { view in
            view.searchable(text: $searchText, isPresented: $isSearching, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search Any Movie Or Person"))
        })
        .onChange(of: searchText) {
            publisher.send(searchText)
        }
        .onReceive(publisher.filter{ !$0.isEmpty }.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)) { value in
            viewModel.searchMovies(with: value)
        }
        .onChange(of: isSearching) {
            if !isSearching {
                selectedSearchFilter = SearchFilter.movies.rawValue
                viewModel.resetSearchData()
            }
        }
        .onAppear() {
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
                        PopularityBadge(score: Int(movie.vote_average * 10))
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
