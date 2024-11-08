//
//  NavigationPath.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import Foundation
import SwiftUI

@Observable
final class Navigation {
    var path = NavigationPath()
}

extension EnvironmentValues {
    private struct NavigationKey: EnvironmentKey {
        static let defaultValue = Navigation()
    }

    var navigation: Navigation {
        get { self[NavigationKey.self] }
        set { self[NavigationKey.self] = newValue }
    }
}

struct MovieListPath: Hashable {
    let listType: MoviesListViewModel.ListType
    let naviTitle: String
    let movies: [Movie]
}

struct PeopleListPath: Hashable {
    let naviTitle: String
    let peoples: [People]
}

struct ImagesListPath: Hashable {
    let images: [ImageData]
    let selectedImage: ImageData
}
