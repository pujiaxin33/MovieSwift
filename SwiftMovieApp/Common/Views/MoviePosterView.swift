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
                ProgressView()
                    .frame(width: size.width(), height: size.height())
            }
        } else {
            ProgressView()
                .frame(width: size.width(), height: size.height())
        }
    }
}

#Preview {
    MoviePosterView(path: nil, urlSize: .medium, size: .medium)
}
