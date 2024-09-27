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
    @State private var favoritePeopleManager: FavoritePeopleManager = .init()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                if !favoritePeopleManager.peoples.isEmpty {
                    Section {
                        ForEach(favoritePeopleManager.peoples) { people in
                            PeopleCardView(people: people)
                        }.onDelete { index in
                            favoritePeopleManager.remove(favoritePeopleManager.peoples[index.first!])
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
            .onAppear {
                viewModel.loadData()
            }
        }
        .environment(\.navigation, navigation)
        .environment(\.favoritePeopleManager, favoritePeopleManager)
    }
}

@Observable
class FavoritePeopleManager {
    private(set) var peoples: [People] = []
    
    func insert(_ people: People) {
        remove(people)
        peoples.insert(people, at: 0)
    }
    
    func remove(_ people: People) {
        peoples.removeAll{ $0.id == people.id }
    }
}

extension EnvironmentValues {
    private class FavoritePeopleManagerKey: EnvironmentKey {
        static let defaultValue: FavoritePeopleManager = .init()
    }
    
    var favoritePeopleManager: FavoritePeopleManager {
        set {
            self[FavoritePeopleManagerKey.self] = newValue
        }
        get {
            return self[FavoritePeopleManagerKey.self]
        }
    }
}
