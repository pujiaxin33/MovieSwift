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
                    Label("Home", systemImage: "tray.and.arrow.down.fill")
                }
                
                Text("Discover").tabItem {
                    Label("Discover", systemImage: "tray.and.arrow.down.fill")
                }
                
                Text("Fan Club").tabItem {
                    Label("Fan Club", systemImage: "tray.and.arrow.down.fill")
                }
                
                Text("My Lists").tabItem {
                    Label("My Lists", systemImage: "tray.and.arrow.down.fill")
                }
            }
        }
    }
}
