//
//  MovieDetail.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct MovieDetail: View {
    let movie: Movie
    
    @State private var isOverviewFolded: Bool = true
    
    var body: some View {
        List {
            header
        }
        .navigationTitle(movie.title)
    }
    
    var header: some View {
        Section {
            movieBasicInfoHeader
            
            overviewHeader
        }
    }
    
    var movieBasicInfoHeader: some View {
        ZStack(alignment: .leading) {
            Color.gray
            
            VStack(alignment: .leading) {
                HStack {
                    if let path = movie.poster_path {
                        AsyncImage(url: ImageService.posterUrl(path: path, size: .medium)) { image in
                            image.resizable()
                                .renderingMode(.original)
                                .posterStyle(loaded: true, size: .medium)
                        } placeholder: {
                            Color.green.posterStyle(loaded: true, size: .medium)
                        }
                    }
                    
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
    
    var overviewHeader: some View {
        VStack(alignment: .leading) {
            Text("Overview").font(.system(size: 15, weight: .bold))
            
            Text(movie.overview)
                .foregroundStyle(Color.gray.opacity(0.5))
                .lineLimit(isOverviewFolded ? 4 : nil)
            
            Button(isOverviewFolded ? "Readmore" : "Less") {
                isOverviewFolded.toggle()
            }.foregroundStyle(Color.blue)
        }
    }
}

#Preview {
    MovieDetail(movie: sampleMovie)
}
