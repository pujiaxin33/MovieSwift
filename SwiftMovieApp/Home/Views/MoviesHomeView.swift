//
//  ContentView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import SwiftUI

struct MoviesHomeView: View {
    
    let viewModel: MoviesHomeViewModel
    
    var body: some View {
        List {
            ForEach(MoviesMenu.allCases, id: \.self) { type in
                if let movies = viewModel.movies[type] {
                    Section {
                        VStack {
                            header
                            
                            moviesList(movies: movies)
                        }
                    }
                }
            }
        }
    }
    
    
    var header: some View {
        Text("")
    }
    
    func moviesList(movies: [Movie]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(movies) { movie in
                    Text(movie.title)
                        .frame(width: 50, height: 100)
                        .background(Color.gray)
                        .cornerRadius(5)
                }
            }
        }.frame(height: 120)
    }
}

#Preview {
    MoviesHomeView(viewModel: .init())
}
