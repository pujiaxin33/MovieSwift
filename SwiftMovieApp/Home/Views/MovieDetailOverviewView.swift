//
//  MovieDetailOverviewView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieDetailOverviewView: View {
    let movie: Movie
    @State private var isOverviewFolded: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Overview").font(.system(size: 15, weight: .bold))
            
            Text(movie.overview)
                .foregroundStyle(Color.gray.opacity(0.5))
                .lineLimit(isOverviewFolded ? 4 : nil)
            
            Button(isOverviewFolded ? "Readmore" : "Less") {
                isOverviewFolded.toggle()
            }
            .foregroundStyle(Color.blue)
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    MovieDetailOverviewView(movie: sampleMovie)
}
