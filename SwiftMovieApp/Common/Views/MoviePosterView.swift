//
//  MoviePosterView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct MoviePosterView: View {
    let path: String?
    let urlSize: ImageService.Size
    let size: PosterStyle.Size
    
    var body: some View {
        if let path {
            AsyncImage(url: ImageService.posterUrl(path: path, size: urlSize)) { image in
                image.resizable()
                    .renderingMode(.original)
                    .posterStyle(loaded: true, size: size)
            } placeholder: {
                Color.green
                    .posterStyle(loaded: true, size: size)
            }
        } else {
            Color.green
                .posterStyle(loaded: true, size: size)
        }
    }
}

#Preview {
    MoviePosterView(path: nil, urlSize: .medium, size: .medium)
}
