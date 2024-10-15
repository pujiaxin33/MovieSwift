//
//  PeopleDetailMovieRow.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct PeopleDetailMovieRow: View {
    let movie: Movie
    
    var body: some View {
        NavigationLink(value: movie) {
            HStack {
                MoviePosterView(path: movie.poster_path, size: .small)
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                    
                    Text(movie.character ?? "")
                }
            }
        }
    }
}

#Preview {
    PeopleDetailMovieRow(movie: sampleMovie)
}
