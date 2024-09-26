//
//  FanClubView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct FanClubView: View {
    let viewModel: FanClubViewModel
    @State var navigation: Navigation = .init()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                if let peoples = viewModel.peoples {
                    Section(header: Text("Popular people to add to your fan club")) {
                        ForEach(peoples) { people in
                            PeopleCardView(people: people)
                        }
                    }
                }
            }
            .registerNavigationDestinations()
            .navigationTitle("Fan Club")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                viewModel.loadData()
            }
        }.environment(\.navigation, navigation)
    }
}

#Preview {
    FanClubView(viewModel: .init())
}
