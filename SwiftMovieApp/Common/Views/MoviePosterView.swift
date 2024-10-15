//
//  MoviePosterView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking
import Kingfisher

struct MoviePosterView: View {
    let path: String?
    let size: PosterStyle.Size
    
    var body: some View {
        if let path {
            KFImage
                .url(ImageService.posterUrl(path: path, size: size.urlSize()))
                .placeholder { _ in
                    ProgressView()
                        .frame(width: size.width(), height: size.height())
                }
                .fade(duration: 0.5)
                .onSuccess { _ in
                }
                .onFailure { _ in
                }
                .resizable()
                .posterStyle(loaded: true, size: size)
            
        } else {
            ProgressView()
                .frame(width: size.width(), height: size.height())
        }
    }
}

#Preview {
    MoviePosterView(path: nil, size: .medium)
}
