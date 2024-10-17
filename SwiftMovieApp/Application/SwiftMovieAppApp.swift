//
//  SwiftMovieAppApp.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI
import Combine

enum AppTab: Int, Equatable {
    case home
    case discover
    case fanClub
    case myLists
}

@main
struct SwiftMovieAppApp: App {
    @State private var appConfiguration: AppConfiguration = .init()
    private let coordinator: AppCoordinator = .init()
    
    init() {
        coordinator.createStorageTables()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $appConfiguration.appTab) {
                coordinator.makeMoviesHomeView()
                    .tabItem {
                        Label("Home", systemImage: "movieclapper.fill")
                    }
                    .tag(AppTab.home)
                
                coordinator.makeDiscoverView()
                    .tabItem {
                        Label("Discover", systemImage: "lanyardcard.fill")
                    }
                    .tag(AppTab.discover)
                
                coordinator.makeFanClubView()
                    .tabItem {
                        Label("Fan Club", systemImage: "star.circle.fill")
                    }
                    .tag(AppTab.fanClub)
                
                coordinator.makeMyListView()
                    .tabItem {
                        Label("My Lists", systemImage: "heart.circle.fill")
                    }
                    .tag(AppTab.myLists)
            }
            .environment(appConfiguration)
            .onAppear() {
                appConfiguration.loadConfigs()
            }
        }
    }
}

@Observable
class AppConfiguration {
    var appVersion: String = ""
    var appTab: AppTab = .home

    func loadConfigs() {
    }
}
