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
            HStack {
                Text("Similar Movies")
                Button {
                    
                } label: {
                    HStack {
                        Text("See all")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                }
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(movies) { movie in
                        if let path = movie.poster_path {
                            AsyncImage(url: ImageService.posterUrl(path: path, size: .medium)) { image in
                                image.resizable()
                                    .renderingMode(.original)
                                    .posterStyle(loaded: true, size: .medium)
                            } placeholder: {
                                Color.green.posterStyle(loaded: true, size: .medium)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SimilarMoviesView(movies: [sampleMovie])
}
