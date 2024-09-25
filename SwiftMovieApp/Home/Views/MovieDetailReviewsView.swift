//
//  MovieDetailReviewsView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieDetailReviewsView: View {
    let reviews: [Review]
    @Environment(\.navigation) var navigation
    
    var body: some View {
        Group {
            HStack {
                Text("\(reviews.count) reviews")
                Spacer()
                Image(systemName: "arrow.right")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                navigation.path.append(reviews)
            }
        }
    }
}

#Preview {
    MovieDetailReviewsView(reviews: [])
}
