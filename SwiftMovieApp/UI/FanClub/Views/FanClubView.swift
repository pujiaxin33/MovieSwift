//
//  FanClubView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct FanClubView: View {
    let coordinator: FanClubCoordinator
    @State var viewModel: FanClubViewModel
    @State private var navigation: Navigation = .init()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                if !viewModel.favoritePeople.isEmpty {
                    Section {
                        ForEach(viewModel.favoritePeople) { people in
                            PeopleCardView(people: people)
                        }.onDelete { index in
                            viewModel.removePeople(people: viewModel.favoritePeople[index.first!])
                        }
                    }
                }
                
                if let peoples = viewModel.peoples {
                    Section(header: Text("Popular people to add to your fan club")) {
                        ForEach(peoples) { people in
                            PeopleCardView(people: people)
                        }
                    }
                }
                //todo: add load more
            }
            .registerFanClubNavigationDestinations(with: coordinator)
            .navigationTitle("Fan Club")
            .navigationBarTitleDisplayMode(.automatic)
            .showLoading($viewModel.isLoading)
            .toastView(toast: $viewModel.toast)
            .onFirstAppear {
                viewModel.loadData()
            }
            .onAppear {
                viewModel.refreshFavoritePeople()
            }
            .refreshable {
                viewModel.loadData()
            }
        }
        .environment(\.navigation, navigation)
    }
}
