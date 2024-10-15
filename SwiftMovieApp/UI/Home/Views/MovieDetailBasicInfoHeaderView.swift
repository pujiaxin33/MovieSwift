//
//  MovieDetailBasicInfoHeaderView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieDetailBasicInfoHeaderView: View {
    let movie: Movie
    @Environment(\.navigation) var navigation
    
    var body: some View {
        ZStack(alignment: .leading) {
            MovieTopBackdropImage(path: movie.poster_path, urlSize: .medium, size: .big)
            
            VStack(alignment: .leading) {
                HStack {
                    MoviePosterView(path: movie.poster_path, urlSize: .medium, size: .medium)
                    
                    VStack(alignment: .leading) {
                        Text(movie.yearDurationStatusDisplayTitle)
                            .foregroundStyle(Color.white)
                            .font(.system(size: 12))
                        if let countryName = movie.production_countries?.first?.name {
                            Text(countryName)
                                .foregroundStyle(Color.white)
                        }
                        
                        HStack {
                            PopularityBadge(score: Int(movie.vote_average * 10), textColor: .white)
                            
                            Text(movie.voteCountText)
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                
                if let genres = movie.genres {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(genres) { genre in
                                Button {
                                    navigation.path.append(MovieListPath(listType: .genre(genre), naviTitle: genre.name, movies: []))
                                } label: {
                                    Label(
                                        genre.name,
                                        systemImage: "arrow.right"
                                    )
                                    .foregroundStyle(Color.black)
                                    .labelStyle(RightIconLabelStyle())
                                }
                                .padding(.horizontal, 5)
                                .background(Color.white)
                                .clipShape(Capsule())
                            }
                        }
                    }
                }
            }
            .padding(15)
        }.listRowInsets(EdgeInsets())
    }
}

#Preview {
    MovieDetailBasicInfoHeaderView(movie: sampleMovie)
}
