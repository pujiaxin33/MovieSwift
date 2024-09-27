//
//  SimilarMoviesView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct MoviesListCardView: View {
    let title: String
    let movies: [Movie]
    @Environment(\.navigation) var navigation
    
    var body: some View {
        VStack {
            SeeAllHeaderView(title: title) { navi in
                navi.path.append(MovieListPath(naviTitle: title, movies: movies))
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(movies) { movie in
                        MoviePosterView(path: movie.poster_path, urlSize: .medium, size: .medium)
                    }
                }
            }
        }
    }
}

#Preview {
    MoviesListCardView(title: "Similar Movies", movies: [sampleMovie])
}
