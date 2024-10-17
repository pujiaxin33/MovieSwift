//
//  MyListView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/14.
//

import SwiftUI

struct MyListView: View {
    let coordinator: UIModuleCoordinator
    @State var viewModel: MyListViewModel
    @State var navigation: Navigation = .init()
    @Environment(AppConfiguration.self) var appConfiguration
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                Section {
                    Picker(selection: $viewModel.listType) {
                        Text("Wishlist")
                            .tag(MoviesListType.wish)
                        
                        Text("Seenlist")
                            .tag(MoviesListType.seen)
                    } label: {
                        Text("")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                if viewModel.showMovies.isEmpty {
                    Button {
                        appConfiguration.appTab = .home
                    } label: {
                        Text("Add movies in home page")
                    }

                } else {
                    Section {
                        ForEach(viewModel.showMovies, id: \.self) { movie in
                            MovieCardView(movie: movie)
                        }
                    } header: {
                        Text("\(viewModel.showMovies.count) Movies in \(viewModel.listType.nameInSectionHeader)")
                    }
                }
            }
            .navigationTitle("My List")
            .registerUIModuleNavigationDestinations(with: coordinator)
            .onAppear {
                viewModel.loadData()
            }
        }.environment(\.navigation, navigation)
    }
}

