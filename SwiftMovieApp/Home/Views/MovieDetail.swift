//
//  MovieDetail.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    
    var body: some View {
        Text(movie.title)
    }
}

#Preview {
    MovieDetail(movie: sampleMovie)
}
