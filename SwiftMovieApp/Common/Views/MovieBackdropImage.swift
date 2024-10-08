//
//  MovieDetailBackdropsRow.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking
import Kingfisher

struct MovieBackdropImage: View {
    enum DisplayMode {
        case background, normal
    }
    
    let path: String?
    @State var displayMode: DisplayMode = .normal
    
    var body: some View {
        if let path {
            KFImage
                .url(ImageService.posterUrl(path: path, size: .original))
                .placeholder { _ in
                    ProgressView()
                        .frame(width: 280, height: displayMode == .normal ? 168 : 50)
                }
                .fade(duration: 0.5)
                .onSuccess { _ in
                }
                .onFailure { _ in
                }
                .resizable()
                .frame(width: 280, height: displayMode == .normal ? 168 : 50)
        } else {
            ProgressView()
                .frame(width: 280, height: displayMode == .normal ? 168 : 50)
        }
    }
}
