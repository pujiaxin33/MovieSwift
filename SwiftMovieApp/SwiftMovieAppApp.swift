//
//  SwiftMovieAppApp.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI

@main
struct SwiftMovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MoviesHomeView(viewModel: .init()).tabItem {
                    Label("Home", systemImage: "movieclapper.fill")
                }
                
                Text("Discover").tabItem {
                    Label("Discover", systemImage: "lanyardcard.fill")
                }
                
                FanClubView(viewModel: .init()).tabItem {
                    Label("Fan Club", systemImage: "star.circle.fill")
                }
                
                Text("My Lists").tabItem {
                    Label("My Lists", systemImage: "heart.circle.fill")
                }
            }
        }
    }
}
