//
//  MovieDetailBackdropsRow.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct MovieBackdropImage: View {
    enum DisplayMode {
        case background, normal
    }
    
    let path: String?
    @State var displayMode: DisplayMode = .normal
    
    var body: some View {
        if let path {
            AsyncImage(url: ImageService.posterUrl(path: path, size: .original)) { image in
                image.resizable()
                    .renderingMode(.original)
                    .frame(width: 280, height: displayMode == .normal ? 168 : 50)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
                    .opacity(0.1)
                    .frame(width: 280, height: displayMode == .normal ? 168 : 50)
            }
        } else {
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.1)
                .frame(width: 280, height: displayMode == .normal ? 168 : 50)
        }
    }
}
