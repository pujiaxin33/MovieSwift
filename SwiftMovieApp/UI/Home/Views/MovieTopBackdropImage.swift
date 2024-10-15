//
//  MovieTopBackdropImage.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/14.
//

import SwiftUI
import Kingfisher
import Networking

struct MovieTopBackdropImage : View {
    let path: String?
    let urlSize: ImageService.Size
    let size: PosterStyle.Size
    
    var body: some View {
        if let path {
            KFImage
                .url(ImageService.posterUrl(path: path, size: urlSize))
                .placeholder { _ in
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.3)
                        .frame(height: 210)
                }
                .fade(duration: 0.5)
                .onSuccess { _ in
                }
                .onFailure { _ in
                }
                .resizable()
                .blur(radius: 50, opaque: true)
                .overlay(Color.black.opacity(0.3))
                .frame(height: 210)
        } else {
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.3)
                .frame(height: 210)
        }
    }
}
