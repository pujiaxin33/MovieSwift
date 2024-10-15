//
//  MovieDetailPosterCardView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieDetailPosterCardView: View {
    let images: [ImageData]
    @Binding var selectedImage: ImageData?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Other posters")
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(images) { image in
                        MoviePosterView(path: image.file_path, size: .medium)
                            .onTapGesture {
                                selectedImage = image
                            }
                    }
                }
            }
        }
    }
}
