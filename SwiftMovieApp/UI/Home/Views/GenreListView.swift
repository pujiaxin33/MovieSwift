//
//  GenreListView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/9.
//

import SwiftUI

struct GenreListView: View {
    let genres: [Genre]
    
    var body: some View {
        List(genres) { genre in
            NavigationLink(value: MovieListPath(listType: .genre(genre), naviTitle: genre.name, movies: [])) {
                Text(genre.name)
            }
        }
        .listStyle(PlainListStyle())
    }
}
