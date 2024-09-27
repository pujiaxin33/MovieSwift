//
//  MovieDetailBasicInfoHeaderView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieDetailBasicInfoHeaderView: View {
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.gray
            
            VStack(alignment: .leading) {
                HStack {
                    MoviePosterView(path: movie.poster_path, urlSize: .medium, size: .medium)
                    
                    VStack(alignment: .leading) {
                        Text(movie.yearDurationStatusDisplayTitle).foregroundStyle(Color.red).background(Color.cyan).font(.system(size: 12))
                        if let countryName = movie.production_countries?.first?.name {
                            Text(countryName)
                        }
                        Text("\(movie.voteAverageText) \(movie.voteCountText)")
                    }
                }
                
                if let genres = movie.genres {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(genres) { genre in
                                Button(genre.name) {
                                    print(genre.name)
                                }
                            }
                        }
                    }
                }
                
            }
        }.listRowInsets(EdgeInsets())
    }
}

#Preview {
    MovieDetailBasicInfoHeaderView(movie: sampleMovie)
}
