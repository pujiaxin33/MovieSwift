//
//  PeopleDetailImagesRow.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct PeopleDetailImagesRow: View {
    let images: [ImageData]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Images")
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 16) {
                    ForEach(images) { image in
                        MoviePosterView(path: image.file_path, urlSize: .medium, size: .medium)
                    }
                }
                .padding(.leading)
            }
        }
        .listRowInsets(EdgeInsets())
        .padding(.vertical)
    }
}

#Preview {
    PeopleDetailImagesRow(images: sampleCasts.first!.images ?? [])
}
