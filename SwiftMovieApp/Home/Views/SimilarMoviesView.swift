//
//  SimilarMoviesView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct SimilarMoviesView: View {
    let movies: [Movie]
    @Environment(\.navigation) var navigation
    
    var body: some View {
        VStack {
            SeeAllHeaderView(title: "Similar Movies") { navi in
                navi.path.append(MovieListPath(naviTitle: "Similar Movies", movies: movies))
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
    SimilarMoviesView(movies: [sampleMovie])
}
