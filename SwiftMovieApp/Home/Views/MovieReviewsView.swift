//
//  MovieReviewsView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct MovieReviewsView: View {
    let reviews: [Review]
    
    var body: some View {
        Text(reviews[0].content)
    }
}

#Preview {
    MovieReviewsView(reviews: [])
}
