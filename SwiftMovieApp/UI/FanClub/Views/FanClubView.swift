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
                
                if viewModel.isRefreshing {
                    VStack {
                        ProgressView {
                            Text("Refreshing...")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.cyan)
                        }
                    }.listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity)
                }
                
                if !viewModel.favoritePeople.isEmpty {
                    Section(header: sectionHeader(title: "Favorite peoples", isFirstSection: true)) {
                        ForEach(viewModel.favoritePeople) { people in
                            PeopleCardView(people: people)
                        }.onDelete { index in
                            viewModel.removePeople(people: viewModel.favoritePeople[index.first!])
                        }
                    }
                }
                
                if let peoples = viewModel.peoples {
                    Section(header: sectionHeader(title: "Popular people to add to your fan club", isFirstSection: viewModel.favoritePeople.isEmpty)) {
                        ForEach(peoples) { people in
                            PeopleCardView(people: people)
                        }
                    }
                }
                
                if !viewModel.isLoadFinished {
                    Section {
                        VStack(alignment: .center) {
                            ProgressView()
                                .tint(Color.blue)
                                .frame(width: 50, height: 50)
                            Text("Loading More")
                        }
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            viewModel.loadData()
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .coordinateSpace(.named("list"))
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
            .listStyle(PlainListStyle())
//            .refreshable {
//                viewModel.loadData()
//            }
        }
        .environment(\.navigation, navigation)
    }
    
    @ViewBuilder
    func sectionHeader(title: String, isFirstSection: Bool) -> some View {
        if isFirstSection {
            Text(title)
                .id(title)
                .readLayoutData(coordinateSpace: .named("list"), onChange: { (data) in
                    print(data.frameInCoordinateSpace.origin.y)
                    if data.frameInCoordinateSpace.origin.y > 230 && !viewModel.isRefreshing {
                        viewModel.startRefresh()
                    }
                })
        } else {
            Text(title)
                .id(title)
        }
    }
                                
}
