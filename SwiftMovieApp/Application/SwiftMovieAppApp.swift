//
//  SwiftMovieAppApp.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI

@main
struct SwiftMovieAppApp: App {
    @State var appConfiguration: AppConfiguration = .init()
    private let coordinator: AppCoordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                coordinator.makeMoviesHomeView().tabItem {
                    Label("Home", systemImage: "movieclapper.fill")
                }
                
                Text("Discover").tabItem {
                    Label("Discover", systemImage: "lanyardcard.fill")
                }
                
                coordinator.makeFanClubView().tabItem {
                    Label("Fan Club", systemImage: "star.circle.fill")
                }
                
                Text("My Lists").tabItem {
                    Label("My Lists", systemImage: "heart.circle.fill")
                }
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
    
    func loadConfigs() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.appVersion = "1.0.0"
        }
    }
}

extension EnvironmentValues {
    private struct AppConfigurationKey: EnvironmentKey {
        static let defaultValue = AppConfiguration()
    }

    var appConfiguration: AppConfiguration {
        get { self[AppConfigurationKey.self] }
        set { self[AppConfigurationKey.self] = newValue }
    }
}
