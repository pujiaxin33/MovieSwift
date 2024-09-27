//
//  MovieDetailbackdropCardView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieDetailbackdropCardView: View {
    let images: [ImageData]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Images")
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(images) { image in
                        MovieBackdropImage(path: image.file_path)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieDetailbackdropCardView(images: [])
}
