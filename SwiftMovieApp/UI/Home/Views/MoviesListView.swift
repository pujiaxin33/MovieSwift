//
//  MoviesListView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct MoviesListView: View {
    let naviTitle: String
    let movies: [Movie]
    var body: some View {
        List(movies) { movie in
            MovieCardView(movie: movie)
        }
        .navigationTitle(naviTitle)
    }
}

struct MovieCardView: View {
    let movie: Movie
    var body: some View {
        NavigationLink(value: movie) {
            HStack {
                MoviePosterView(path: movie.poster_path, urlSize: .medium, size: .medium)
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .foregroundStyle(Color.yellow)
                    
                    HStack {
                        Text(movie.voteAverageText)
                        if let date = movie.release_date {
                            Text(date)
                        }
                    }
                    
                    Text(movie.overview)
                        .lineLimit(3)
                }
            }
        }
    }
}

#Preview {
    MoviesListView(naviTitle: "test", movies: [sampleMovie])
}
